require 'rails_helper'

describe SsoAuth::SessionController, type: :request do
  let(:doctor) { create :doctor, password: '123456' }
  let(:sso) { Base64.encode64("return_sso_url=http://www.example.com") }
  let(:sign) { SsoService.new.sign(sso) }

  context 'GET /sso' do
    before { ENV["DISCOURSE_SSO_SECRET"] = "baz" }

    it 'with wrong sso or sig should render 404' do
      get '/sso', {}, 'HTTP_REFERER' => 'http://foo.com'
      expect(response).to have_http_status(:not_found)
    end

    it 'should get login page at GET /sso' do
      get '/sso', { sso: sso, sig: sign }, 'HTTP_REFERER' => 'http://foo.com'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("<form action=\"sso\" accept-charset=\"UTF-8\" method=\"post\">")
    end
  end

  describe 'POST /sso with wrong credentials' do
    let(:params) do
      { user: { email: doctor.email, password: '12345678' } }
    end
    subject { post '/sso', params }
    it { expect(subject).to redirect_to('/sso') }
  end

  describe 'POST /sso with right credentials' do
    let(:payload) { SsoService.new(sso: sso, logged: doctor).payload }
    let(:return_sso_url) { "http://www.foo.com/session/sso_login?#{payload}" }
    let(:params) do
      { user: { email: doctor.email, password: '123456' },
        sso: sso,
        redirect_to: "http://www.foo.com" }
    end
    subject { post '/sso', params }
    it 'should redirect back to referer' do
      expect(subject).to redirect_to(return_sso_url)
    end
  end
end

require 'rails_helper'
require 'factory_girl'

describe SsoAuth::SessionController, type: :request do
  let(:user) { create :user }
  let(:sso) { "cmV0dXJuX3Nzb191cmw9aHR0cDovL3d3dy5leGFtcGxlLmNvbQ==\n" }
  let(:sign) { "55eee83a37b982c34d0cbb1e523cf1346c023663137267850a5f3523c814395d" }
  before do
    Configuration.sso_user = 'User'
    Configuration.sso_secret = 'LinuxRulezz'
  end

  context 'GET /sso/session' do
    before { ENV["DISCOURSE_SSO_SECRET"] = "baz" }

    it 'with wrong sso or sig should render 302' do
      get '/sso/session', {}, 'HTTP_REFERER' => 'http://foo.com'
      expect(response).to redirect_to('http://www.example.com/sso/session')
    end

    it 'should get login page at GET /sso/session' do
      get '/sso/session', { sso: sso, sig: sign }, 'HTTP_REFERER' => 'http://foo.com'
      expect(response).to have_http_status(:ok)
      # expect(response.body).to include("<form action=\"sso\" accept-charset=\"UTF-8\" method=\"post\">")
    end
  end

  describe 'POST /sso with wrong credentials' do
    let(:params) do
      { user: { email: user.email, password: '12345678' } }
    end
    subject { post '/sso/session', params }
    it { expect(subject).to redirect_to('/sso/session') }
  end

  describe 'POST /sso with right credentials' do
    let(:payload) { Session.new(sso: sso, user: user).payload }
    let(:return_sso_url) { "http://www.foo.com/session/sso_login?#{payload}" }
    let(:params) do
      { user: { email: user.email, password: '123456' },
        sso: sso,
        redirect_to: "http://www.foo.com" }
    end
    subject { post '/sso/session', params }
    it 'should redirect back to referer' do
      expect(subject).to redirect_to(return_sso_url)
    end
  end
end

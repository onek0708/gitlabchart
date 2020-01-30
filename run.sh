# edit gitlab.rb in pod
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.gmail.com"
gitlab_rails['smtp_port'] = 587
gitlab_rails['smtp_user_name'] = "act.sre.dev@gmail.com"
gitlab_rails['smtp_password'] = "jeep8walrus!"
gitlab_rails['smtp_domain'] = "smtp.gmail.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = false
gitlab_rails['smtp_openssl_verify_mode'] = 'peer'

gitlab_rails['omniauth_enabled'] = true
gitlab_rails['omniauth_block_auto_created_users'] = false
gitlab_rails['omniauth_allow_single_sign_on'] = ['oauth2_generic']
# gitlab_rails['omniauth_auto_sign_in_with_provider'] = 'oauth2_generic'

gitlab_rails['omniauth_providers'] = [{
        'name' => 'oauth2_generic',
        'app_id' => 'gitlab',
        'app_secret' => 'd6c077f0-5da9-401f-bb0f-dbb5d2c9f799',
        'args' => {
                        client_options: {
                                        'site' => 'http://keycloak.example.com', # including port if necessary
                                        'user_info_url' => '/auth/realms/Kubernetes/protocol/openid-connect/userinfo',
                                        'authorize_url' => '/auth/realms/Kubernetes/protocol/openid-connect/auth',
                                        'token_url' => '/auth/realms/Kubernetes/protocol/openid-connect/token',
                        },
                        user_response_structure: {
                                #root_path: ['user'], # i.e. if attributes are returned in JsonAPI format (in a 'user' node nested under a 'data' node)
                                attributes: { email:'email', first_name:'given_name', last_name:'family_name', name:'name', nickname:'preferred_username' }, # if the nickname attribute of a user is called 'username'
                                id_path: 'preferred_username'
                        }
        }
}]

# run gitlab-ctl reconfigure

helm install --name gitlab --namespace=git -f values.yaml --set externalUrl=http://gitlab.example.com/ stable/gitlab-ce

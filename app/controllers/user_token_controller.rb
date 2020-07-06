class UserTokenController < Knock::AuthTokenController
  include ExceptionHandler
  include Response
  skip_before_action :verify_authenticity_token, raise: false

end

class Publish::BaseService
  def publish(_user, _publish_job)
    raise NotImplementedError('This service is not available or activated.')
  end
end

class BulkUploadPolicy < ApplicationPolicy
  def new?
    user.admin?
  end

  def show?
    new? && owner?
  end

  def create?
    new?
  end

  private

  def owner?
    record.uploader.eql?(user)
  end
end

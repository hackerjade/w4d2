# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :datetime
#  end_date   :datetime
#  status     :string           default("PENDING")
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  belongs_to(:cat)

  after_initialize :update_status

  def update_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
    other_request = CatRentalRequest.where([
      "(cat_id = ? ) AND
      (start_date < ? AND end_date > ?)",
      cat_id, end_date, start_date])
  end

  def approved_overlapping_requests
    approved = overlapping_requests.where(["status = 'APPROVED'"])
    approved.empty? ? self.status = "APPROVED" : self.status = "DENIED"
  end

  def overlapping_pending_requests

  end
end

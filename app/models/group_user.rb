class GroupUser < ApplicationRecord
    belongs_to :user
    belongs_to :group
 
    enum status: { pending: 0, accepted: 1, rejected: 2 } #申請、承認、拒否
end

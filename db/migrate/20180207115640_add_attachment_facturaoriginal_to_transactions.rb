class AddAttachmentFacturaoriginalToTransactions < ActiveRecord::Migration
  def self.up
    change_table :transactions do |t|
      t.attachment :facturaoriginal
    end
  end

  def self.down
    remove_attachment :transactions, :facturaoriginal
  end
end

require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it 'decreases quality by 1' do
      items = [Item.new("TestItem", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 19
    end

    it 'lowers the SellIn value by 1 each day' do
      items = [Item.new("TestItem", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 9
    end

    it 'can never have a negative sell in value' do
        items = [Item.new("TestItem", 0, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
    end

    it 'decreases in quality twice as fast when the sell_in date is negative' do
      items = [Item.new("TestItem", -1, 4)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it 'quality can never be negative' do
      items = [Item.new("TestItem", -1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).not_to eq -1
      expect(items[0].quality).to eq 0
    end




  end

end

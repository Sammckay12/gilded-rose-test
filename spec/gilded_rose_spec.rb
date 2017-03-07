require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    context 'regular items' do
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

      it 'can have a negative sell in value' do
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

    context 'Aged Brie' do
      it 'quality increases as the sell_in  decreases' do
        items = [Item.new("Aged Brie", 5, 5)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end
      it 'quality can never be more than 50' do
        items = [Item.new("Aged Brie", 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).not_to eq 51
        expect(items[0].quality).to eq 50
      end
    end

    context 'Sulfuras, Hand of Ragnaros. The legendary item' do
      it 'quality never decreases' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 30)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 30
      end
      it 'sell_in never decreases' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 30)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 10
      end
    end

    context 'Backstage passes' do
      it 'quality increases by 1 as sell_in value is more than 10' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 30)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 31
      end
      it 'quality increases by 2 as sell_in value is less than 10' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 8, 30)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 32
      end
      it 'quality increases by 3 as sell_in value is less than 5' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 30)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 33
      end
      it 'quality drops to 0 as sell_in hits 0' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      context 'Conjured items' do
        it 'quality decreases by 2' do
          items = [Item.new("Conjured ...", 10, 30)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 28
        end
        # it 'sell_in never decreases' do
        #   items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 30)]
        #   GildedRose.new(items).update_quality()
        #   expect(items[0].sell_in).to eq 10
        # end
      end

    end



  end

end

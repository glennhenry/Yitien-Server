package com.yiTian.view.modules.Shopping
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Sprite;
   
   public class View_items_got extends Sprite
   {
      
      private var cost_txt:MyTextField;
      
      private var title_txt:MyTextField;
      
      public function View_items_got()
      {
         super();
         this.cost_txt = ComponentUtil.getTextField("999,999,999",this,{
            "x":72.25 - 8,
            "y":0,
            "size":12
         });
         this.title_txt = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":0,
            "size":12
         });
         this.cost_txt.textColor = 16383744;
      }
      
      public function reset() : void
      {
         this.cost_txt.text = "";
         this.title_txt.text = "";
      }
      
      public function update(index:int, wp_id:int = 0) : void
      {
         if(index == 1)
         {
            this.title_txt.htmlText = HtmlUtil.font(LangConfig.getWord("116",0),"#04ff00");
            this.cost_txt.text = Utils.getGapNum(String(GameUnitManager.hero.prestige));
         }
         else if(index == 2)
         {
            this.title_txt.htmlText = HtmlUtil.font(LangConfig.getWord("117",0),"#04ff00");
            this.cost_txt.text = Utils.getGapNum(String(GameUnitManager.hero.money));
         }
         else if(index == 3)
         {
            this.title_txt.htmlText = HtmlUtil.font(LangConfig.getWord("117",0),"#04ff00");
            this.cost_txt.text = Utils.getGapNum(String(GameUnitManager.hero.money));
         }
         else
         {
            if(index == 4)
            {
               return;
            }
            if(index == 5)
            {
               this.title_txt.htmlText = HtmlUtil.font(LangConfig.getWord("118",0),"#04ff00");
               this.cost_txt.text = Utils.getGapNum(String(GameUnitManager.hero.liquan));
            }
            else if(index == 7)
            {
               this.title_txt.htmlText = HtmlUtil.font(LangConfig.getWord("117",0),"#04ff00");
               this.cost_txt.text = Utils.getGapNum(String(GameUnitManager.hero.money));
            }
         }
      }
      
      public function getCount(wp_id:int) : int
      {
         var count:int = 0;
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[wp_id]);
         var i:int = 0;
         while(i < vec.length)
         {
            count += vec[i].count;
            i++;
         }
         return count;
      }
      
      public function update_txt(wp_id:int) : void
      {
         var voItem:Vo_item = new Vo_item();
         voItem.id = wp_id;
         voItem.Init_lib();
         this.title_txt.htmlText = HtmlUtil.font(voItem.str_name,Model_shop.get_color_arr[voItem.color - 1]) + "：";
         this.cost_txt.text = " " + String(Model_store.getCount(wp_id));
      }
   }
}


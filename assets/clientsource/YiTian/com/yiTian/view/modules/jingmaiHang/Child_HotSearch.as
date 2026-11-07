package com.yiTian.view.modules.jingmaiHang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MartCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   
   public class Child_HotSearch extends Sprite
   {
      
      public static var _isShow:Boolean;
      
      private static const hotName:Array = ["宠物内丹","经络丹","成长丹","英雄令"];
      
      private static const propId:Array = [46315,46280,46307,46255];
      
      private static const SEARCH_NAME:Array = ["宠物","经络丹合成卷","成长丹","英雄令"];
      
      public static var Seach_Name_text:String = "";
      
      public function Child_HotSearch()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var t:MyTextField = null;
         var t1:MyTextField = null;
         var grid:View_Grid = null;
         var item:Vo_item = null;
         var i:int = 0;
         var hotLogo:Bitmap = Utils.getLoadBitmap("resource/image/jingmaihang/Text_RMSS.png");
         this.addChild(hotLogo);
         var k:int = 3;
         while(k >= 0)
         {
            hotName[k] = HtmlUtil.underLine(hotName[k]);
            hotName[k] = HtmlUtil.font(hotName[k],"#d56200",11);
            hotName[k] = HtmlUtil.link(hotName[k],propId[k]);
            k--;
         }
         t = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":-3
         });
         t.htmlText = hotName[0];
         t1 = ComponentUtil.getTextField("",this,{
            "x":121,
            "y":13 + 2
         });
         t1.htmlText = hotName[1];
         var t2:MyTextField = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":13 + 2
         });
         t2.htmlText = hotName[2];
         var t3:MyTextField = ComponentUtil.getTextField("",this,{
            "x":121,
            "y":-3
         });
         t3.htmlText = hotName[3];
         t.mouseEnabled = true;
         t1.mouseEnabled = true;
         t2.mouseEnabled = true;
         t3.mouseEnabled = true;
         t.addEventListener(TextEvent.LINK,this.onClick);
         t1.addEventListener(TextEvent.LINK,this.onClick);
         t2.addEventListener(TextEvent.LINK,this.onClick);
         t3.addEventListener(TextEvent.LINK,this.onClick);
         i = 0;
         while(i < 4)
         {
            grid = new View_Grid();
            grid.x = i % 2 * 72 + 35;
            grid.y = i > 1 ? -1 : 18;
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_tf_count(true,false,true);
            var _temp_1:* = grid;
            grid.scaleY = 0.42;
            _temp_1.scaleX = 0.42;
            this.addChild(grid);
            item = new Vo_item();
            item.id = propId[i];
            item.Init_lib();
            grid.vo = item;
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         _isShow = value;
      }
      
      private function onClick(evt:TextEvent) : void
      {
         View_JiMaiHang.isSearchType = 1;
         if(!evt.text || evt.text == "")
         {
            return;
         }
         Seach_Name_text = SEARCH_NAME[propId.indexOf(int(evt.text))];
         if(View_JiMaiHang.mart_type == 1)
         {
            View_JiMaiHang.isSearched["sell"] = true;
         }
         else if(View_JiMaiHang.mart_type == 2)
         {
            View_JiMaiHang.isSearched["buy"] = true;
         }
         if(UIManager.JMH_panel.now.text == LangConfig.getWord("367",0))
         {
            MartCGMessage.CG_SEARCH(1,Seach_Name_text,0,0,0,0,1,View_JiMaiHang.searchPrice["sell"]);
         }
         else if(UIManager.JMH_panel.now.text == LangConfig.getWord("368",0))
         {
            MartCGMessage.CG_SEARCH(2,Seach_Name_text,0,0,0,0,1,View_JiMaiHang.searchPrice["buy"]);
         }
      }
   }
}


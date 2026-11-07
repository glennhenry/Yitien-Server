package com.yiTian.view.modules.quest
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_quest_dailyAccept extends Panel
   {
      
      private var Button_Use:Button;
      
      private var Button_Unuse:Button;
      
      private var Button_Store:Button;
      
      private var grids:Array = [];
      
      private var itemIds:Array = [46252,46253,46254,46255];
      
      private var exps:Array = [1.25,1.5,1.75,2];
      
      private var titleBm:Bitmap;
      
      private var nowGrid:View_Grid;
      
      private var _callBack:Function;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_quest_dailyAccept()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var grid:View_Grid = null;
         var expTf:MyTextField = null;
         var i:int = 0;
         var item:Vo_item = null;
         move = new Rectangle(0,0,428,36);
         this.titleBm = new Bitmap();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":428,
            "height":300
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":380,
            "height":250
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":34,
            "y":219,
            "width":360,
            "height":60
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Invite",[5,5,6,6],this,{
            "x":34,
            "y":72,
            "width":360,
            "height":80
         },Global.Img_Cdm);
         var title2:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("10476",1),this,{
            "x":39,
            "y":50,
            "color":11527396,
            "size":12,
            "leading":0
         });
         var title3:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("10323",1),this,{
            "x":50,
            "y":194,
            "color":11527396,
            "size":12,
            "leading":0
         });
         var title4:MyTextField = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":226,
            "color":11527396,
            "size":12,
            "leading":0
         });
         title4.multiline = true;
         title4.htmlText = LangConfig.getWord("10324",1);
         this.Button_Use = ComponentUtil.getButton(LangConfig.getWord("10325",1),"Button_Orange",this,{
            "x":100,
            "y":155,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Use.addEventListener(MouseEvent.CLICK,this.useYXL);
         this.Button_Unuse = ComponentUtil.getButton(LangConfig.getWord("10326",1),"Button_Five",this,{
            "x":250,
            "y":155,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Unuse.addEventListener(MouseEvent.CLICK,this.unuseYXL);
         this.Button_Store = ComponentUtil.getButton(LangConfig.getWord("10327",1),"Button_store",this,{
            "x":151,
            "y":187,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Store.addEventListener(MouseEvent.CLICK,this.storeLink);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":394,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         i = 0;
         while(i < 4)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.QUEST_DAILY;
            grid.set_tf_count(true,true,true);
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_bmp_select();
            grid.x = 71 + i * 83;
            grid.y = 86;
            grid.isAutoLoad = false;
            grid.index = i;
            grid.addEventListener(MouseEvent.CLICK,this.selYXL);
            addChild(grid);
            this.grids.push(grid);
            item = new Vo_item();
            item.id = this.itemIds[i];
            item.Init_lib();
            grid.vo = item;
            expTf = ComponentUtil.getTextField(this.exps[i] + LangConfig.getWord("10328",1),this,{
               "x":grid.x - 2,
               "y":122,
               "realWidth":40,
               "color":14662240
            });
            expTf.align = TextFormatAlign.CENTER;
            i++;
         }
      }
      
      private function selYXL(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(this.nowGrid == grid)
         {
            return;
         }
         if(Boolean(this.nowGrid))
         {
            this.nowGrid.bSelect = false;
         }
         this.nowGrid = grid;
         this.nowGrid.bSelect = true;
      }
      
      private function storeLink(e:MouseEvent) : void
      {
         UIManager.special_btn.smsHandle();
      }
      
      public function set callBack(value:Function) : void
      {
         this._callBack = value;
      }
      
      private function useYXL(e:MouseEvent) : void
      {
         if(!this.nowGrid)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10477",1));
            return;
         }
         if(!this.nowGrid.count)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10478",1));
            return;
         }
         if(this._callBack != null)
         {
            this._callBack(this.nowGrid.vo.id);
         }
      }
      
      private function unuseYXL(e:MouseEvent) : void
      {
         if(this._callBack != null)
         {
            this._callBack(-1);
         }
      }
      
      public function update() : void
      {
         var grid:View_Grid = null;
         if(!visible)
         {
            return;
         }
         var i:int = 0;
         while(i < 4)
         {
            grid = this.grids[i];
            grid.count = CommandManager.get_bag_count(grid.vo.id);
            i++;
         }
         this.setDefault();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               Utils.loadTitle("lang/ch/RCRenWu_Imgs.swf","Title_JQRenWu",this.titleBm,{
                  "x":134,
                  "y":5
               },this);
               this.setGridLoad();
               this.isFirstOpen = false;
            }
            this.update();
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.update);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.update);
            if(Boolean(this.nowGrid))
            {
               this.nowGrid.bSelect = false;
               this.nowGrid = null;
            }
         }
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this.grids.length)
         {
            this.grids[i].isAutoLoad = true;
            this.grids[i].beginLoad();
            i++;
         }
      }
      
      private function setDefault() : void
      {
         var grid:View_Grid = null;
         if(Boolean(this.nowGrid) && Boolean(this.nowGrid.count))
         {
            return;
         }
         var i:int = 3;
         while(i >= 0)
         {
            grid = this.grids[i];
            if(Boolean(grid.count))
            {
               grid.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            i--;
         }
         if(this.nowGrid != this.grids[3])
         {
            this.grids[3].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}


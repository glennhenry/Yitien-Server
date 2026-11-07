package com.yiTian.view.modules.MiJingCangZong
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextFieldType;
   
   public class Item extends Sprite
   {
      
      private var itemID:int;
      
      private var prizeTxt:MyTextField;
      
      private var itemName:MyTextField;
      
      private var buyNum:MyTextField;
      
      private var buyBtn:Button;
      
      private var upBtn:Button;
      
      private var downBtn:Button;
      
      private var grid:View_Grid;
      
      private var prize:int;
      
      public function Item()
      {
         super();
         this.Init();
      }
      
      private function Init() : void
      {
         ComponentUtil.getScaleBitmap("Store_Back2",[50,30,4,1],this,{
            "x":0,
            "y":0,
            "width":208,
            "height":111
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getScaleBitmap("Store_Back3",[3,3,4,4],this,{
            "x":83,
            "y":73,
            "width":62,
            "height":24
         },Global.ChunJie_Imgsdm);
         ComponentUtil.getTextField("售价：",this,{
            "x":88,
            "y":46,
            "color":5757360,
            "size":12,
            "leading":0
         });
         this.itemName = ComponentUtil.getTextField("",this,{
            "x":66,
            "y":3,
            "color":3394815,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,null);
         this.grid.x = 9;
         this.grid.y = 32;
         addChild(this.grid);
         this.prizeTxt = ComponentUtil.getTextField("0粽子",this,{
            "x":129,
            "y":46,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.buyNum = ComponentUtil.getTextField("1",this,{
            "x":100,
            "y":76,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":40,
            "restrict":"0-9",
            "maxChars":3
         },"center",TextFieldType.INPUT);
         this.buyNum.addEventListener(Event.CHANGE,this.updateBuyNum);
         this.buyBtn = ComponentUtil.getButton("购买","Button_Buy",this,{
            "x":149,
            "y":72,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.buyBtn.callBack = function():void
         {
            if(CommandManager.get_bag_count(44701) < Number(buyNum.text) * prize)
            {
               UIManager.centerBroadcast.addMsg("粽子不足");
               return;
            }
            DailyActCGMessage.CG_MiJingCangZong_BUY(itemID,int(buyNum.text));
         };
         this.upBtn = ComponentUtil.getButton("","Button_Nup",this,{
            "x":124,
            "y":74,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.upBtn.callBack = function():void
         {
            buyNum.text = String(Number(buyNum.text) + 1);
            updateBuyNum(null);
         };
         this.downBtn = ComponentUtil.getButton("","Button_Ndown",this,{
            "x":124,
            "y":84,
            "textColor":16184781
         },Global.ChunJie_Imgsdm);
         this.downBtn.callBack = function():void
         {
            buyNum.text = String(Number(buyNum.text) - 1);
            updateBuyNum(null);
         };
      }
      
      public function setItem(itemID:int, cost:int) : void
      {
         this.itemID = itemID;
         this.itemName.text = Data_lib.item[itemID][Enum_lib_item.STR_NAME];
         this.prize = cost;
         this.prizeTxt.text = cost + "粽子";
         var vo:Vo_item = new Vo_item();
         vo.id = itemID;
         vo.Init_lib();
         this.grid.vo = vo;
      }
      
      private function updateBuyNum(e:Event) : void
      {
         if(int(this.buyNum.text) > 99)
         {
            this.buyNum.text = "99";
         }
         else if(int(this.buyNum.text) < 1 || this.buyNum.text == "")
         {
            this.buyNum.text = "1";
         }
      }
   }
}


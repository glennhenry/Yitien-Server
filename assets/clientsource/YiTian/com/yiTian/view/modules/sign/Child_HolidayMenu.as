package com.yiTian.view.modules.sign
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SignCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.nationalTreasure.Enum_NationalTreasure;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class Child_HolidayMenu extends Sprite
   {
      
      private var txtDes:MyTextField;
      
      private var grid:View_Grid;
      
      private var gridArr:Array = [];
      
      private var btn:Button;
      
      public function Child_HolidayMenu()
      {
         super();
         ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,16],this,{
            "x":15,
            "y":5,
            "width":300,
            "height":26
         },Global.Img_Cdm);
         this.txtDes = ComponentUtil.getTextField("资源塔*00",this,{
            "x":5,
            "y":7,
            "color":13424242,
            "size":12,
            "leading":0,
            "multiline":true,
            "wordWrap":true
         });
         this.txtDes.realWidth = 304;
         this.txtDes.align = TextFormatAlign.CENTER;
         this.txtDes.htmlText = "资源塔*00";
         this.btn = ComponentUtil.getButton("领取奖励","Button_TwoBule91",this,{
            "x":113,
            "y":80,
            "textColor":16184781
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < Enum_Sign.HOLIDAY_REWARD_MAX_NUM)
         {
            this.grid = new View_Grid();
            this.grid.set_bmp_bg();
            this.grid.set_bmp_over(true,null);
            this.grid.set_tf_count(true,false,true);
            addChild(this.grid);
            this.grid.x = 10 + i * 65;
            this.grid.y = 35;
            this.gridArr.push(this.grid);
            i++;
         }
         this.btn.addEventListener(MouseEvent.CLICK,this.gain);
         this.btn.enabled = false;
      }
      
      public static function get instance() : Child_HolidayMenu
      {
         return Singleton.getInstance(Child_HolidayMenu);
      }
      
      public function update(holiday:String, day:int, arr:Array) : void
      {
         var i:int = 0;
         var data:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         if(!arr || !arr.length)
         {
            return;
         }
         View_SignPanel.instance.holidayStatusChange();
         var len:int = int(arr.length);
         i = 0;
         while(i < len)
         {
            if(Boolean(this.gridArr[i]))
            {
               data = arr[i].toString().split("_");
               _type = int(data[0]);
               _id = int(data[1]);
               _count = int(data[2]);
               if(_type == Enum_NationalTreasure.ITEM)
               {
                  _voI = new Vo_item();
                  _voI.id = _id;
                  _voI.Init_lib();
                  _voI.count = _count;
                  (this.gridArr[i] as View_Grid).vo = _voI;
               }
               else if(_type == Enum_NationalTreasure.EQUIP)
               {
                  _voE = new Vo_equip();
                  _voE.id = _id;
                  _voE.Init_lib();
                  _voE.count = _count;
                  (this.gridArr[i] as View_Grid).vo = _voE;
               }
            }
            i++;
         }
      }
      
      public function setBtnEnable(value:Boolean) : void
      {
         this.btn.enabled = value;
      }
      
      public function setLabel(v:String) : void
      {
         this.txtDes.htmlText = v;
      }
      
      private function gain(e:MouseEvent) : void
      {
         var freeGrid:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(freeGrid < 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("50005",5));
            return;
         }
         SignCGMessage.CG_HOLIDAY_REWARD();
      }
      
      public function flyIcon() : void
      {
         var i:int = 0;
         while(i < this.gridArr.length)
         {
            if(Boolean(this.gridArr[i]))
            {
               ComboTweenStep.toBag(this.gridArr[i]);
            }
            i++;
         }
      }
   }
}


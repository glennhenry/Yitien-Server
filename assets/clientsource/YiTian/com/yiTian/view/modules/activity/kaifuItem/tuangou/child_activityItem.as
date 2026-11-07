package com.yiTian.view.modules.activity.kaifuItem.tuangou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.nationalTreasure.Enum_NationalTreasure;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class child_activityItem extends Sprite
   {
      
      private var textDes:MyTextField;
      
      private var grid:View_Grid;
      
      private var gridArr:Array = [];
      
      private var btn:Button;
      
      private var id:int;
      
      private var index:int;
      
      private var btnLabalArr:Array = ["不可领取","可领取","已领取","不可领取"];
      
      private var btnNormal:Button;
      
      private var numTF:MyTextField;
      
      private var lastClickTime:uint;
      
      public function child_activityItem()
      {
         super();
         this.textDes = ComponentUtil.getTextField("资源塔*00",this,{
            "x":-15,
            "y":9,
            "color":13424242,
            "size":12,
            "leading":0,
            "multiline":true,
            "wordWrap":true
         });
         this.textDes.leading = 5;
         this.textDes.realWidth = 150;
         this.textDes.align = TextFormatAlign.LEFT;
         this.numTF = ComponentUtil.getTextField("资源塔*00",this,{
            "x":61,
            "y":25,
            "color":13424242,
            "size":12,
            "leading":0,
            "multiline":true,
            "wordWrap":true
         });
         this.numTF.realWidth = 80;
         this.numTF.align = TextFormatAlign.LEFT;
         this.btnNormal = ComponentUtil.getButton("不可领取","Button_Orange",this,{
            "x":337,
            "y":15,
            "textColor":16184781,
            "callBack":this.gain
         },Global.Img_Cdm);
         this.btn = this.btnNormal;
         this.btn.visible = false;
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":5,
            "y":50,
            "width":410,
            "height":2
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < 5)
         {
            this.grid = new View_Grid();
            this.grid.set_bmp_bg();
            this.grid.set_bmp_over(true,null);
            this.grid.set_tf_count(true,false,true);
            addChild(this.grid);
            this.grid.x = 103 + i * 46;
            this.grid.y = 12;
            this.grid.visible = false;
            this.gridArr.push(this.grid);
            i++;
         }
      }
      
      private function checkBtnVisible(value:Boolean) : void
      {
         this.btn.visible = value;
      }
      
      private function gain(e:MouseEvent) : void
      {
         switch(this.id)
         {
            case Enum_KF.ID_SHOUCHONGTUANGOU:
               DailyActCGMessage.CG_ShouCHongTuanGou_GETAWARD(this.index);
         }
         AcitivityVo.awardIndex = this.index;
      }
      
      public function update(id:int, index:int, des:String, statusDes:String, arr:Array, des1:String) : void
      {
         var i:int = 0;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         if(!arr || !arr.length)
         {
            return;
         }
         var len:int = int(arr.length);
         this.id = id;
         this.index = index;
         this.numTF.htmlText = des;
         this.btn = this.btnNormal;
         this.btnNormal.visible = true;
         this.textDes.x = 5;
         switch(id)
         {
            case Enum_KF.ID_SHOUCHONGTUANGOU:
               this.btn.label = this.btnLabalArr[int(statusDes)];
               this.checkBtnVisible(true);
               if(int(statusDes) == 1)
               {
                  this.btn.enabled = true;
                  this.btn.label = this.btnLabalArr[1];
                  break;
               }
               if(int(statusDes) == 2)
               {
                  this.btn.enabled = false;
                  this.btn.label = this.btnLabalArr[2];
                  break;
               }
               this.btn.enabled = false;
               this.btn.label = this.btnLabalArr[0];
         }
         this.textDes.htmlText = des1;
         i = 0;
         while(i < 5)
         {
            this.gridArr[i].visible = false;
            this.gridArr[i].x = 103 + i * 46;
            i++;
         }
         i = 0;
         while(i < len)
         {
            if(Boolean(this.gridArr[i]))
            {
               _type = int(arr[i][0]);
               _id = int(arr[i][1]);
               _count = int(arr[i][2]);
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
                  _voE.bBind = true;
                  (this.gridArr[i] as View_Grid).vo = _voE;
               }
               this.gridArr[i].visible = true;
            }
            i++;
         }
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
         this.btn.enabled = false;
         this.btn.label = this.btnLabalArr[2];
      }
      
      public function get state() : Boolean
      {
         if(this.btn.enabled)
         {
            return true;
         }
         return false;
      }
   }
}


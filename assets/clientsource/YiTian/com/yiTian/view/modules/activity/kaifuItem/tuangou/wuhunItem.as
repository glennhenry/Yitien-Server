package com.yiTian.view.modules.activity.kaifuItem.tuangou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.nationalTreasure.Enum_NationalTreasure;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class wuhunItem extends Sprite
   {
      
      private var textDes:MyTextField;
      
      private var grid:View_Grid;
      
      private var btn:Button;
      
      private var lastClickTime:uint;
      
      private var index:int;
      
      private var id:int;
      
      private var idIndex:int;
      
      private var gridArr:Array = [];
      
      private var btnArr:Array = [];
      
      private var btnLabalArr:Array = ["免费领取","周卡领取","月卡领取","半年卡领取"];
      
      private var btnLabalArr1:Array = ["苍狼领取","雄狮领取","独角兽领取","麒麟领取"];
      
      private var bm:Bitmap;
      
      private var bmArr:Array = [];
      
      private var zuoQiArr:Array = [2,3,4];
      
      private var numTF:MyTextField;
      
      private var eff:Effect;
      
      public function wuhunItem(id:int, idIndex:int)
      {
         var i:int = 0;
         super();
         this.textDes = ComponentUtil.getTextField("资源塔*00",this,{
            "x":-15,
            "y":15,
            "color":13424242,
            "size":12,
            "leading":0,
            "multiline":true,
            "wordWrap":true
         });
         this.textDes.leading = 10;
         this.textDes.realWidth = 180;
         this.textDes.align = TextFormatAlign.LEFT;
         this.numTF = ComponentUtil.getTextField("资源塔*00",this,{
            "x":61,
            "y":35,
            "color":13424242,
            "size":12,
            "leading":0,
            "multiline":true,
            "wordWrap":true
         });
         this.numTF.realWidth = 80;
         this.numTF.align = TextFormatAlign.LEFT;
         this.id = id;
         this.idIndex = idIndex;
         i = 0;
         while(i < 4)
         {
            this.grid = new View_Grid();
            this.grid.set_bmp_bg();
            this.grid.set_bmp_over(true,null);
            this.grid.set_tf_count(true,false,true);
            this.grid.x = 78 * i + 124;
            this.grid.y = 5;
            addChild(this.grid);
            this.gridArr.push(this.grid);
            this.btn = ComponentUtil.getButton("","Button_Orange",this,{
               "x":78 * i + 108,
               "y":45,
               "textColor":16184781,
               "callBack":this.gain,
               "name":i + 1 + ""
            },Global.Img_Cdm);
            this.btnArr.push(this.btn);
            this.bm = Utils.getLoadBitmap("resource/image/tuanGou/yilingqu.png",null,{
               "x":80 * i + 110,
               "y":30
            });
            addChild(this.bm);
            this.bmArr.push(this.bm);
            this.bm.visible = false;
            ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
               "x":5,
               "y":73,
               "width":410,
               "height":2
            },Global.Img_Cdm);
            i++;
         }
      }
      
      private function gain(e:MouseEvent) : void
      {
         var i:int = 0;
         this.index = int((e.target as Button).name);
         var count:int = 0;
         switch(this.id)
         {
            case Enum_KF.ID_WUHUNTUANGOU:
               i = 0;
               while(i < 3)
               {
                  if(i < this.idIndex)
                  {
                     count += 4;
                  }
                  i++;
               }
               count += this.index;
               DailyActCGMessage.CG_WuHunTuanGou_GETAWARD(count);
               break;
            case Enum_KF.ID_ZUOQITUANGOU:
               i = 0;
               while(i < this.zuoQiArr.length)
               {
                  if(i < this.idIndex)
                  {
                     count += this.zuoQiArr[i];
                  }
                  i++;
               }
               count += this.index;
               DailyActCGMessage.CG_ZuoQiTuanGou_GETAWARD(count);
         }
         AcitivityVo.awardIndex = this.index;
         AcitivityVo.idIndex = this.idIndex;
      }
      
      public function updateItemPos(arr:Array) : void
      {
         var i:int = 0;
         var len:int = int(arr.length);
         i = 0;
         while(i < len)
         {
            if(this.id == Enum_KF.ID_WUHUNTUANGOU)
            {
               this.btnArr[i].label = this.btnLabalArr[i];
            }
            else if(this.id == Enum_KF.ID_ZUOQITUANGOU)
            {
               this.btnArr[i].label = this.btnLabalArr1[i];
            }
            i++;
         }
         i = len;
         while(i < 4)
         {
            this.gridArr[i].visible = false;
            this.btnArr[i].visible = false;
            this.bmArr[i].visible = false;
            i++;
         }
      }
      
      public function update(id:int, index:int, des:String, statusDes:Array, arr:Array, des1:String) : void
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
         this.id = id;
         this.index = index;
         this.textDes.htmlText = des1;
         this.textDes.x = 5;
         this.numTF.htmlText = des;
         this.updateItem(arr);
         var len:int = int(arr.length);
         i = 0;
         while(i < statusDes.length)
         {
            switch(id)
            {
               case Enum_KF.ID_WUHUNTUANGOU:
               case Enum_KF.ID_ZUOQITUANGOU:
                  if(int(statusDes[i]) == 1)
                  {
                     this.bmArr[i].visible = false;
                     this.btnArr[i].enabled = true;
                     this.btnArr[i].visible = true;
                  }
                  else if(Boolean(int(statusDes[i] == 2)))
                  {
                     this.bmArr[i].visible = true;
                     this.btnArr[i].enabled = false;
                     this.btnArr[i].visible = false;
                  }
                  else
                  {
                     this.bmArr[i].visible = false;
                     this.btnArr[i].enabled = false;
                     this.btnArr[i].visible = true;
                  }
            }
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
                  (this.gridArr[i] as View_Grid).vo = _voE;
               }
               this.gridArr[i].visible = true;
               if(Boolean(this.eff))
               {
                  EffectManager.removeEffect(this.eff);
                  this.eff = null;
               }
               if(_id == 44641)
               {
                  if(id == Enum_KF.ID_ZUOQITUANGOU)
                  {
                     if(!this.eff)
                     {
                        this.eff = EffectManager.addEffect("35176",this.gridArr[i],1200,17,18,true);
                     }
                  }
               }
            }
            i++;
         }
      }
      
      public function flyIcon() : void
      {
         if(Boolean(this.gridArr[this.index - 1]))
         {
            ComboTweenStep.toBag(this.gridArr[this.index - 1]);
         }
         this.btnArr[this.index - 1].enabled = false;
         this.btnArr[this.index - 1].visible = false;
         this.bmArr[this.index - 1].visible = true;
      }
      
      public function updateItem(arr:Array) : void
      {
         var tempArr:Array = [];
         var i:int = 0;
         while(i < arr.length)
         {
            tempArr.push(arr[i].length);
            i++;
         }
         this.updateItemPos(tempArr);
      }
      
      public function get state() : Boolean
      {
         var i:int = 0;
         while(i < this.btnArr.length)
         {
            if(Boolean(this.btnArr[i].enabled))
            {
               return true;
            }
            i++;
         }
         return false;
      }
   }
}


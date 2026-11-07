package com.yiTian.view.modules.KFHomeland.KFHomeTuoZhan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.KFHomeland.HomeLandCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_GetDanQiPan extends Panel123
   {
      
      private var getBtn:Button;
      
      private var sp1:Sprite;
      
      private var sp2:Sprite;
      
      private var sp3:Sprite;
      
      private var sp4:Sprite;
      
      private var spVec:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var bmp:Bitmap;
      
      private var type:int = 4;
      
      public function View_GetDanQiPan()
      {
         super();
         regResource("lang/ch/KFJY.swf","KFJYdm");
      }
      
      public static function get instance() : View_GetDanQiPan
      {
         return Singleton.getInstance(View_GetDanQiPan);
      }
      
      override protected function initUI2() : void
      {
         var sp:Sprite = null;
         var item:DanQiItem = null;
         var item1:Bitmap = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":502,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":453,
            "height":220
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":467,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         move = new Rectangle(0,0,460,35);
         initDynamicView();
         ComponentUtil.getBitmap("Back_LQDQ",this,{
            "x":37,
            "y":52
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Title_LQDQ",this,{
            "x":172,
            "y":5
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Icon_DanQi",this,{
            "x":87,
            "y":182
         },Global.KFJYdm);
         var tf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":65,
            "y":187,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("light_LQDQ",this,{
            "x":52,
            "y":215
         },Global.KFJYdm);
         ComponentUtil.getTextField("每天可以领取一次，",this,{
            "x":65,
            "y":226,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("丹气是宠物尊丹进阶必需品",this,{
            "x":172,
            "y":226,
            "color":16383744,
            "size":12,
            "leading":0
         });
         tf.htmlText = "<font color=\'#f9ff00\'>" + "注：      为4点丹气，" + "</font>" + "<font color=\'#ffffff\'>" + "达到对应繁荣度可消耗家园币选择领取更高的奖励" + "</font>";
         this.sp1 = new Sprite();
         this.sp2 = new Sprite();
         this.sp3 = new Sprite();
         this.sp4 = new Sprite();
         this.sp1.name = "sp_1";
         this.sp2.name = "sp_2";
         this.sp3.name = "sp_3";
         this.sp4.name = "sp_4";
         addChild(this.sp1);
         addChild(this.sp2);
         addChild(this.sp3);
         addChild(this.sp4);
         this.sp1.x = 66;
         this.sp2.x = 165;
         this.sp3.x = 263;
         this.sp4.x = 362;
         this.sp1.y = this.sp2.y = this.sp3.y = this.sp4.y = 82;
         this.spVec.push(this.sp1,this.sp2,this.sp3,this.sp4);
         var data:DictionaryTabel = Data_lib.jiayuanyouhua;
         var i:int = 1;
         while(i < 5)
         {
            if(i < 4)
            {
               item = new DanQiItem();
               item.updateData(data[i][0],data[i][1]);
               this["sp" + i].addChild(item);
            }
            else
            {
               item1 = ComponentUtil.getBitmap("Frame_LQDQ",this,{
                  "x":0,
                  "y":0
               },Global.KFJYdm);
               this["sp" + i].addChild(item1);
            }
            i++;
         }
         for each(sp in this.spVec)
         {
            var _temp_3:* = sp;
            sp.useHandCursor = true;
            _temp_3.buttonMode = true;
            sp.mouseChildren = false;
            sp.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         }
         ComponentUtil.getBitmap("Icon_SSYB",this,{
            "x":270,
            "y":90
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Icon_MianFei",this,{
            "x":72,
            "y":90
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Icon_YESYB",this,{
            "x":369,
            "y":90
         },Global.KFJYdm);
         ComponentUtil.getBitmap("Icon_HuoYue",this,{
            "x":172,
            "y":90
         },Global.KFJYdm);
         this.bmp = ComponentUtil.getBitmap("Frame_XZK",this,{
            "x":357,
            "y":77
         },Global.KFJYdm);
         this.getBtn = ComponentUtil.getButton("","Button_Orange7026",this,{
            "x":366,
            "y":223,
            "textColor":16771436
         },Global.Img_Cdm);
         this.getBtn.callBack = this.getHandler;
         ComponentUtil.getTextField("领取",this,{
            "x":387,
            "y":226,
            "color":16772287,
            "size":12,
            "leading":0
         });
      }
      
      private function getHandler(e:MouseEvent) : void
      {
         var str:String = null;
         var typeStr:String = null;
         if(this.type != 4)
         {
            typeStr = Data_lib.jiayuanyouhua[this.type][1] + "家园币";
         }
         else
         {
            typeStr = Data_lib.jiayuanyouhua[this.type][2] + "元宝";
         }
         str = "<font color=\'#ffffff\'>" + "确定花费" + "</font>" + "<font color=\'#f9ff00\'>" + typeStr + "</font>" + "<font color=\'#ffffff\'>" + "领取该奖励？" + "</font>";
         switch(this.type)
         {
            case 4:
               Vo_TipPan.count = 72;
               break;
            case 3:
               Vo_TipPan.count = 48;
               break;
            case 2:
               Vo_TipPan.count = 40;
               break;
            case 1:
               Vo_TipPan.count = 4;
         }
         View_Alert.show(str,View_Alert.OK_CANCAL,function():void
         {
            HomeLandCGMessage.CG_ASK_SURE_GET(2,type);
         });
      }
      
      private function onMouseClick(e:MouseEvent) : void
      {
         var sp:Sprite = null;
         sp = e.target as Sprite;
         this.bmp.x = sp.x - 5;
         this.bmp.y = sp.y - 5;
         switch(e.target.name)
         {
            case "sp_1":
               this.type = 1;
               break;
            case "sp_2":
               this.type = 2;
               break;
            case "sp_3":
               this.type = 3;
               break;
            case "sp_4":
               this.type = 4;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Sprite;

class DanQiItem extends Sprite
{
   
   public var fanRongDu:MyTextField;
   
   public var jiaYuanBi:MyTextField;
   
   public function DanQiItem()
   {
      super();
      ComponentUtil.getBitmap("Frame_LQDQ",this,{
         "x":0,
         "y":0
      },Global.KFJYdm);
      ComponentUtil.getBitmap("Text_FanJia",this,{
         "x":3,
         "y":50
      },Global.KFJYdm);
      this.fanRongDu = ComponentUtil.getTextField("1234",this,{
         "x":43,
         "y":48,
         "color":327424,
         "size":12,
         "leading":2
      });
      this.jiaYuanBi = ComponentUtil.getTextField("1234",this,{
         "x":43,
         "y":65,
         "color":327424,
         "size":12,
         "leading":2
      });
   }
   
   public function updateData(boom:int, jiayuanBi:int) : void
   {
      this.fanRongDu.text = String(boom);
      this.jiaYuanBi.text = String(jiayuanBi);
   }
}

package com.yiTian.view.modules.actions.liushiBack
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.LiuShiBackCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class LiushiBackPan extends Panel123
   {
      
      private var closeBtn:Button;
      
      private var getBtn1:Button;
      
      private var getBtn2:Button;
      
      private var getBtn3:Button;
      
      private var getBtn4:Button;
      
      private var getBtn5:Button;
      
      private var getBtn6:Button;
      
      private var getBtn7:Button;
      
      private var myTextField:MyTextField;
      
      private var btnArr:Array = new Array();
      
      private var imgArr:Array = [];
      
      private var currentID:int;
      
      public function LiushiBackPan()
      {
         super();
         regResource("lang/ch/XZHG.swf","XZHGdm");
      }
      
      public static function get instance() : LiushiBackPan
      {
         return Singleton.getInstance(LiushiBackPan);
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         var str:String = null;
         var _giftArr:Array = null;
         var m:int = 0;
         var grid:View_Grid = null;
         var __giftArr:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var ef:Effect = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":680,
            "height":454
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":41,
            "width":629,
            "height":402
         },Global.Img_Cdm);
         move = new Rectangle(0,0,630,35);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":645,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.closeBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         ComponentUtil.getBitmap("Back_YTHG",this,{
            "x":35,
            "y":50
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Text_HGDL",this,{
            "x":95,
            "y":101
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Title_XZHG",this,{
            "x":259,
            "y":5
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Back_JDT",this,{
            "x":45,
            "y":344
         },Global.XZHGdm);
         this.getBtn1 = ComponentUtil.getButton("未领取","Button_LingQu",this,{
            "x":80,
            "y":395,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.XZHGdm);
         this.getBtn2 = ComponentUtil.getButton("未领取","Button_LingQu",this,{
            "x":156,
            "y":395,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.XZHGdm);
         this.getBtn3 = ComponentUtil.getButton("未领取","Button_LingQu",this,{
            "x":232,
            "y":395,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.XZHGdm);
         this.getBtn4 = ComponentUtil.getButton("未领取","Button_LingQu",this,{
            "x":308,
            "y":395,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.XZHGdm);
         this.getBtn5 = ComponentUtil.getButton("未领取","Button_LingQu",this,{
            "x":384,
            "y":395,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.XZHGdm);
         this.getBtn6 = ComponentUtil.getButton("未领取","Button_LingQu",this,{
            "x":460,
            "y":395,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.XZHGdm);
         this.getBtn7 = ComponentUtil.getButton("未领取","Button_LingQu",this,{
            "x":536,
            "y":395,
            "textColor":16771436,
            "callBack":this.onClickHandle
         },Global.XZHGdm);
         ComponentUtil.getTextField("亲！欢迎回来！我们为您准备",this,{
            "x":115,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.myTextField = ComponentUtil.getTextField("",this,{
            "x":115,
            "y":171,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Line_JDT",this,{
            "x":49,
            "y":347
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Hand_JDT",this,{
            "x":108,
            "y":340
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Hand_JDT",this,{
            "x":185,
            "y":340
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Hand_JDT",this,{
            "x":260,
            "y":340
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Hand_JDT",this,{
            "x":337,
            "y":340
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Hand_JDT",this,{
            "x":411,
            "y":340
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Hand_JDT",this,{
            "x":488,
            "y":340
         },Global.XZHGdm);
         ComponentUtil.getBitmap("Hand_JDT",this,{
            "x":563,
            "y":340
         },Global.XZHGdm);
         ComponentUtil.getTextField("登录第1天",this,{
            "x":86,
            "y":362,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("登录第2天",this,{
            "x":164,
            "y":362,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("登录第3天",this,{
            "x":238,
            "y":362,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("登录第4天",this,{
            "x":315,
            "y":362,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("登录第5天",this,{
            "x":390,
            "y":362,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("登录第6天",this,{
            "x":462,
            "y":362,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("登录第7天",this,{
            "x":539,
            "y":362,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.getBtn1.enabled = false;
         this.getBtn2.enabled = false;
         this.getBtn3.enabled = false;
         this.getBtn4.enabled = false;
         this.getBtn5.enabled = false;
         this.getBtn6.enabled = false;
         this.getBtn7.enabled = false;
         this.getBtn1.name = "领取奖励1";
         this.getBtn2.name = "领取奖励2";
         this.getBtn3.name = "领取奖励3";
         this.getBtn4.name = "领取奖励4";
         this.getBtn5.name = "领取奖励5";
         this.getBtn6.name = "领取奖励6";
         this.getBtn7.name = "领取奖励7";
         this.btnArr = [this.getBtn1,this.getBtn2,this.getBtn3,this.getBtn4,this.getBtn5,this.getBtn6,this.getBtn7];
         i = 0;
         while(i < 7)
         {
            str = Data_lib.xiazhehuigui[i + 1][1];
            _giftArr = str.split(",");
            this.imgArr[i] = [];
            m = 0;
            while(m < _giftArr.length)
            {
               grid = new View_Grid();
               grid.set_bmp_bg();
               grid.set_bmp_over();
               grid.set_bmp_select();
               grid.set_tf_count(true,true,true);
               grid.x = 98 + i * 75;
               grid.y = 295 - m * 45;
               addChild(grid);
               __giftArr = (_giftArr[m] as String).split("_");
               _type = int(__giftArr[0]);
               _id = int(__giftArr[1]);
               _count = int(__giftArr[2]);
               if(_type == 1)
               {
                  voI = new Vo_item();
                  voI.id = _id;
                  voI.Init_lib();
                  grid.vo = voI;
                  grid.count = _count;
               }
               else if(_type == 2)
               {
                  voE = new Vo_equip();
                  voE.id = _id;
                  voE.Init_lib();
                  grid.vo = voE;
                  grid.count = _count;
               }
               this.imgArr[i].push(grid);
               if(i == 1 && m == 0 || i == 1 && m == 1 || i == 6 && m == 0 || i == 6 && m == 1 || i == 6 && m == 5)
               {
                  ef = EffectManager.addEffect("35180",this,1000,grid.x + 42,grid.y + 42,true);
                  ef.scaleX = 0.5;
                  ef.scaleY = 0.5;
               }
               m++;
            }
            i++;
         }
      }
      
      private function onClickHandle(e:MouseEvent) : void
      {
         switch(e.target.name)
         {
            case "领取奖励1":
               this.currentID = 1;
               break;
            case "领取奖励2":
               this.currentID = 2;
               break;
            case "领取奖励3":
               this.currentID = 3;
               break;
            case "领取奖励4":
               this.currentID = 4;
               break;
            case "领取奖励5":
               this.currentID = 5;
               break;
            case "领取奖励6":
               this.currentID = 6;
               break;
            case "领取奖励7":
               this.currentID = 7;
         }
         LiuShiBackCGMessage.CG_LIUSHIBACK_AWARD(this.currentID);
      }
      
      public function update(arr:Array, day:int) : void
      {
         if(visible == false)
         {
            return;
         }
         var dayTxt:String = day.toString();
         this.myTextField.htmlText = "已经连续登录" + "<font color=\'#00CD00\'>" + dayTxt + "</font>" + "天";
         var n:int = 0;
         while(n < 7)
         {
            switch(arr[n])
            {
               case 0:
                  this.btnArr[n].enabled = false;
                  this.btnArr[n].label = "未领取";
                  break;
               case 1:
                  this.btnArr[n].enabled = true;
                  this.btnArr[n].label = "可领取";
                  break;
               case 2:
                  this.btnArr[n].enabled = false;
                  this.btnArr[n].label = "已领取";
            }
            n++;
         }
      }
      
      public function giftFly() : void
      {
         var giftGrid:View_Grid = null;
         var i:int = 0;
         while(i < this.imgArr[this.currentID - 1].length)
         {
            if(Boolean(this.imgArr[this.currentID - 1][i]))
            {
               giftGrid = this.imgArr[this.currentID - 1][i] as View_Grid;
            }
            if(Boolean(giftGrid))
            {
               Tween.gridToBagBezierFuncDef(giftGrid);
            }
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}


package com.yiTian.view.modules.tianmingjj
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianmingJJCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.text.TextFieldAutoSize;
   import flash.utils.setTimeout;
   
   public class View_TMLevelUpPanel extends Panel123
   {
      
      private var gird1:Child_Tianming;
      
      private var gird2:Child_Tianming;
      
      private var nameTxt1:MyTextField;
      
      private var nameTxt2:MyTextField;
      
      private var effect1:MyTextField;
      
      private var effect2:MyTextField;
      
      private var costTM:MyTextField;
      
      private var currentTxt:MyTextField;
      
      private var upBtn:Button;
      
      private var temp:String;
      
      public function View_TMLevelUpPanel()
      {
         super();
         regResource("lang/ch/TianMing.swf","TianMingdm");
      }
      
      public static function get instance() : View_TMLevelUpPanel
      {
         return Singleton.getInstance(View_TMLevelUpPanel);
      }
      
      override protected function initUI2() : void
      {
         var closeBtn:Button;
         var tip:MyTextField;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":484,
            "height":314
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":26,
            "y":41,
            "width":434,
            "height":264
         },Global.Img_Cdm);
         closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":449,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":38,
            "y":53,
            "width":410,
            "height":240
         },Global.TianMingdm);
         ComponentUtil.getBitmap("Title_DJTM",this,{
            "x":162,
            "y":5
         },Global.TianMingdm);
         ComponentUtil.getBitmap("Back_TMJJ",this,{
            "x":46,
            "y":208
         },Global.TianMingdm);
         ComponentUtil.getBitmap("Back_DJSJ",this,{
            "x":46,
            "y":61
         },Global.TianMingdm);
         ComponentUtil.getBitmap("Back_DJSJ",this,{
            "x":301,
            "y":61
         },Global.TianMingdm);
         ComponentUtil.getBitmap("Icon_TMJT",this,{
            "x":204,
            "y":87
         },Global.TianMingdm);
         this.nameTxt1 = ComponentUtil.getTextField("冀（冥级）LV8",this,{
            "x":73,
            "y":75,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.nameTxt2 = ComponentUtil.getTextField("冀（冥级）LV8",this,{
            "x":328,
            "y":75,
            "color":16646144,
            "size":12,
            "leading":0
         });
         this.effect1 = ComponentUtil.getTextField("攻击：+20000",this,{
            "x":114,
            "y":199,
            "color":16777215,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.effect2 = ComponentUtil.getTextField("攻击：+20000",this,{
            "x":368,
            "y":198,
            "color":16777215,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.costTM = ComponentUtil.getTextField("",this,{
            "x":186,
            "y":183,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.costTM.htmlText = "<font color=\'#ffffff\'>消耗天命点：</font>15000";
         this.currentTxt = ComponentUtil.getTextField("当前天命点：15000",this,{
            "x":186,
            "y":211,
            "color":327424,
            "size":12,
            "leading":0
         });
         tip = ComponentUtil.getTextField("",this,{
            "x":63,
            "y":244,
            "color":327424,
            "size":12,
            "leading":0
         });
         tip.htmlText = "<font color=\'#ffffff\'><font color=\'#04ff00\'>双击天命骰(活动产出)</font>打开天命投掷界面，天命投掷可以获得天命点</font>";
         this.upBtn = ComponentUtil.getButton("进阶","Button_Four",this,{
            "x":207,
            "y":268,
            "textColor":16771436
         },Global.Img_Cdm);
         this.gird1 = new Child_Tianming(Enum_type_grid.TIANMING,null);
         this.gird1.x = 96;
         this.gird1.y = 128;
         this.addChild(this.gird1);
         this.gird2 = new Child_Tianming(Enum_type_grid.TIANMING,null);
         this.gird2.x = 352;
         this.gird2.y = 128;
         this.addChild(this.gird2);
         closeBtn.callBack = function():void
         {
            visible = false;
         };
         this.upBtn.callBack = function():void
         {
            TianmingJJCGMessage.CG_TMJJ_JJ_START(Model_TianmingJJ.currentUpSysId);
         };
      }
      
      public function show(vec:Vector.<Vo_TianMing>) : void
      {
         var typeStr:String = null;
         var vo:Vo_TianMing = null;
         this.visible = true;
         vo = vec[0];
         this.gird1.updata(vo,vo.gridId);
         this.gird1.lock = vo.lock;
         this.nameTxt1.htmlText = vo.str_name + "LV." + vo.level;
         typeStr = Data_lib.attribute[vo.type_result][0];
         this.effect1.htmlText = "<font color=\'#FFFF00\'>" + typeStr + "+" + vo.value + "</font>";
         vo = vec[1];
         this.gird2.updata(vo,vo.gridId);
         this.gird2.lock = vo.lock;
         this.nameTxt2.htmlText = vo.str_name + "LV." + vo.level;
         typeStr = Data_lib.attribute[vo.type_result][0];
         this.effect2.htmlText = "<font color=\'#FFFF00\'>" + typeStr + "+" + vo.value + "</font>";
         this.temp = vo.str_name.charAt(0);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.currentTxt.htmlText = "<font color=\'#ffffff\'>当前天命点：</font>" + Model_TianmingJJ.currentTMD;
         }
      }
      
      public function showEffect() : void
      {
         var b:int;
         var bm:Bitmap = null;
         var tempBmd:BitmapData = null;
         var _x:int = 0;
         var _y:int = 0;
         var end:Function = null;
         var tempX:int = 0;
         var tempY:int = 0;
         end = function():void
         {
            UIManager.centerBroadcast.addMsg("恭喜你获得了" + temp + "(帝级)",1);
            setTimeout(function():void
            {
               visible = false;
            },300);
         };
         setTimeout(end,2000);
         _x = this.gird2.x;
         _y = this.gird2.y;
         b = 0;
         while(b < 8)
         {
            tempBmd = this.gird1.grid.bmp_icon.bitmapData.clone();
            bm = new Bitmap();
            bm.bitmapData = tempBmd;
            this.addChild(bm);
            tempX = Math.random() * 250 - 50;
            tempY = Math.random() * 100 - 100;
            Tween.to(bm,400 + b * 50,{
               "alpha":[1,0.8],
               "x":[this.gird1.x,tempX],
               "y":[this.gird1.y,tempY]
            },function(bm:Bitmap):void
            {
               Tween.to(bm,500,{
                  "alpha":[1,0.8],
                  "x":[bm.x,_x - 10],
                  "y":[bm.y,_y - 10]
               },function(bm:Bitmap):void
               {
                  if(Boolean(bm))
                  {
                     bm.parent.removeChild(bm);
                     bm.bitmapData = null;
                  }
                  Tween.to(gird2,500,{
                     "alpha":[0.8,0.5],
                     "scaleX":[1,2],
                     "scaleY":[1,2],
                     "x":[_x,_x - 24],
                     "y":[_y,_y - 24]
                  },function():void
                  {
                     gird2.x = 352;
                     gird2.y = 128;
                     var _temp_1:* = gird2;
                     gird2.scaleY = 1;
                     _temp_1.scaleX = 1;
                     gird2.alpha = 1;
                  });
               });
            });
            b++;
         }
      }
   }
}


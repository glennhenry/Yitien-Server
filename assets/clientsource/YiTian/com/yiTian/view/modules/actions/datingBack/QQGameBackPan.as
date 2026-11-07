package com.yiTian.view.modules.actions.datingBack
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_QQGameBack;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.net.message.cg.DaTingHuiGuiCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class QQGameBackPan extends Panel123
   {
      
      private var _LQBtn:Button;
      
      public var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var bmp:Bitmap;
      
      private var getBtn:Button;
      
      private var myTF:MyTextField;
      
      private var vo:Vo_valuable;
      
      public function QQGameBackPan()
      {
         super();
         regResource("lang/ch/DTHL.swf","DTHLdm");
      }
      
      public static function get instance() : QQGameBackPan
      {
         return Singleton.getInstance(QQGameBackPan);
      }
      
      override protected function initUI2() : void
      {
         var g:View_Grid = null;
         var tf:MyTextField = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":566,
            "height":397
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":41,
            "width":516,
            "height":347
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_YTHG",this,{
            "x":204,
            "y":5
         },Global.DTHLdm);
         ComponentUtil.getScaleBitmap("Back_TwoDi",[5,5,1,1],this,{
            "x":34,
            "y":49,
            "width":499,
            "height":329
         },Global.DTHLdm);
         ComponentUtil.getBitmap("Back_NRK",this,{
            "x":40,
            "y":208
         },Global.DTHLdm);
         ComponentUtil.getBitmap("Back_YTTBHG",this,{
            "x":40,
            "y":55
         },Global.DTHLdm);
         ComponentUtil.getBitmap("Back_WZD",this,{
            "x":35,
            "y":163
         },Global.DTHLdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":530,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         move = new Rectangle(0,0,520,35);
         ComponentUtil.getTextField("亲爱的朋友，欢迎回归《倚天》，您的小伙伴们肯定惊呆了，更多的回归活动等你参加，\n赶紧与您的小伙伴们并肩作战！",this,{
            "x":59,
            "y":317,
            "color":13631385,
            "size":12,
            "leading":0
         });
         this.myTF = ComponentUtil.getTextField("",this,{
            "x":146,
            "y":175,
            "color":16383744,
            "size":14,
            "leading":0
         });
         this.getBtn = ComponentUtil.getButton("","BT_BQ",this,{
            "x":399,
            "y":235,
            "textColor":16771436
         },Global.DTHLdm);
         ComponentUtil.getTextField("领取礼包",this,{
            "x":429,
            "y":238,
            "color":15724479,
            "size":12,
            "leading":0
         });
         this.getBtn.callBack = this.getHandle;
         initDynamicView();
         var i:int = 0;
         while(i < 4)
         {
            g = new View_Grid(true);
            g.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            g.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            g.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            g.x = 72 + i * 75;
            g.y = 215;
            addChild(g);
            tf = ComponentUtil.getTextField("",this,{
               "x":g.x + 42,
               "y":g.y + 48
            });
            this.tfVec.push(tf);
            this.gridVec.push(g);
            i++;
         }
      }
      
      public function show(result:int, day:int) : void
      {
         var __arr:Array = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var g:View_Grid = null;
         var tf:MyTextField = null;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var _result:int = result;
         if(!visible)
         {
            visible = true;
         }
         var ss:String = day.toString() + "天";
         this.myTF.htmlText = "您有" + "<font color=\'#04ff00\'>" + ss + "</font>" + "未登录游戏，赶紧领取您的回归礼包";
         var str:String = Data_lib.QQGameBack[_result][Enum_QQGameBack.GOODS];
         var _arr:Array = str.split(",");
         var i:int = 0;
         while(i < _arr.length)
         {
            __arr = (_arr[i] as String).split("_");
            _type = int(__arr[Enum_QQGameBack.TYPE]);
            _id = int(__arr[Enum_QQGameBack.ID]);
            _count = int(__arr[Enum_QQGameBack.COUNT]);
            g = this.gridVec[i];
            tf = this.tfVec[i];
            tf.text = _count.toString();
            if(_type == 1)
            {
               voI = new Vo_item();
               voI.id = _id;
               voI.Init_lib();
               g.vo = voI;
            }
            else if(_type == 2)
            {
               voE = new Vo_equip();
               voE.id = _id;
               voE.Init_lib();
               g.vo = voE;
            }
            i++;
         }
      }
      
      private function getHandle(e:MouseEvent) : void
      {
         this.getBtn.enabled = false;
         DaTingHuiGuiCGMessage.CG_QQGAME_AWARD_BACK();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 663) / 2;
         y = (Global.stage.stageHeight - 451) / 2;
      }
   }
}


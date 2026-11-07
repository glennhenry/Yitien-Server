package com.yiTian.view.modules.treeDownCL
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.gc.TreeDownCLGCMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class ActionEndTipPan extends SmallPan
   {
      
      private static var _instance:ActionEndTipPan;
      
      public static var experiences:int;
      
      private var tf:MyTextField;
      
      public function ActionEndTipPan()
      {
         super();
         regSource("DaShu_Imgsdm","DaShu_Imgs");
      }
      
      public static function get instance() : ActionEndTipPan
      {
         if(!_instance)
         {
            _instance = new ActionEndTipPan();
         }
         return _instance;
      }
      
      override protected function initSource() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":369,
            "height":206
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":332,
            "y":6,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":320,
            "height":156
         },Global.Img_Cdm);
         ComponentUtil.getButton("确定","Button_Four",this,{
            "x":93,
            "y":155,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         ComponentUtil.getButton("取消","Button_Four",this,{
            "x":205,
            "y":155,
            "textColor":16771436,
            "callBack":this.hide
         },Global.Img_Cdm);
         this.tf = ComponentUtil.getTextField("",this,{
            "x":69,
            "y":64,
            "color":16776960,
            "size":12,
            "leading":7,
            "realWidth":237,
            "multiline":true,
            "wordWrap":true
         });
         var ttff:MyTextField = ComponentUtil.getTextField("",this,{
            "x":64,
            "y":118,
            "color":16776960,
            "size":12,
            "leading":0
         });
         ttff.htmlText = "注：每天回答" + HtmlUtil.font("20","#04ff00") + "道题后，只获得基础经验奖励";
         ComponentUtil.getBitmap("Title_DSJL",this,{
            "x":108,
            "y":5
         },Global.DaShu_Imgsdm);
      }
      
      public function hide(e:MouseEvent = null) : void
      {
         super.visible = false;
      }
      
      public function show() : void
      {
         var exp:int;
         var arr:Array = null;
         if(!visible)
         {
            this.visible = true;
         }
         exp = experiences;
         if(TreeDownCLGCMessage.lastAnswerRecord == 0)
         {
            ++Model_treeCL.inCorrectNums;
         }
         else if(TreeDownCLGCMessage.lastAnswerRecord == 1)
         {
            ++Model_treeCL.correctNums;
         }
         arr = [Model_treeCL.correctNums,Model_treeCL.inCorrectNums,experiences];
         super.init(null,function():void
         {
            var n:int = 0;
            var ss:String = "今日活动累计回答正确：{0}  回答错误：{1}\n共计获得经验值：{2}";
            var i:int = 0;
            while(i < 3)
            {
               n = int(arr[i]);
               ss = ss.replace("{" + i + "}",HtmlUtil.font(n.toString(),"#04ff00"));
               i++;
            }
            tf.htmlText = ss;
            experiences = 0;
            Model_treeCL.correctNums = 0;
            Model_treeCL.inCorrectNums = 0;
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         var sx:int = 0;
         var sy:int = 0;
         var n:int = 0;
         if(value)
         {
            super.visible = value;
            sx = (Global.stage.stageWidth - 375) / 2 + 375 / 2;
            sy = (Global.stage.stageHeight - 200) / 2 + 200 / 2;
            Tween.to(this,200,{
               "scaleX":[0,1],
               "scaleY":[0,1],
               "x":[sx,sx - 375 / 2],
               "y":[sy,sy - 200 / 2]
            });
            n = int(setTimeout(function():void
            {
               visible = false;
            },5000));
         }
         else
         {
            Tween.to(this,500,{
               "y":[this.y,this.y - 200],
               "alpha":[1,0]
            },function():void
            {
               hide();
            });
         }
      }
   }
}


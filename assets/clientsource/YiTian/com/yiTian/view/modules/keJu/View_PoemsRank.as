package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_PoemsRank extends Panel
   {
      
      private static var _instance:View_PoemsRank;
      
      private var time:int;
      
      private var startTime:Number;
      
      private var myTimeTF:MyTextField;
      
      private var itemArr:Vector.<PoemsRankItem>;
      
      public function View_PoemsRank()
      {
         super();
         init();
      }
      
      public static function get instance() : View_PoemsRank
      {
         if(!_instance)
         {
            _instance = new View_PoemsRank();
         }
         return _instance;
      }
      
      public function updata() : void
      {
         var item:PoemsRankItem = null;
         var i:int = 0;
         while(i < 3)
         {
            item = this.itemArr[i];
            if(i < Model_KeJu.poemsRankArr.length)
            {
               item.updata(Model_KeJu.poemsRankArr[i],i + 1);
            }
            else
            {
               item.dispose();
            }
            i++;
         }
      }
      
      public function changInfo(num:int) : void
      {
         this.time = num;
         this.myTimeTF.htmlText = LangConfig.getWord("60193",6) + DateUtil.transDate(this.time);
         this.startTime = getTimer();
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler))
         {
            return;
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler);
      }
      
      private function loopHandler() : void
      {
         if(getTimer() - this.startTime >= 1000)
         {
            this.myTimeTF.htmlText = LangConfig.getWord("60193",6) + DateUtil.transDate(++this.time);
            this.startTime = getTimer();
         }
      }
      
      override protected function initStaticView() : void
      {
         bAutoRemove = false;
         ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this,{
            "x":0,
            "y":0,
            "width":300,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60194",6),this,{
            "x":132,
            "y":6,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60001",6),this,{
            "x":45,
            "y":33,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60186",6),this,{
            "x":95,
            "y":33,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("80056",8),this,{
            "x":160,
            "y":33,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60195",6),this,{
            "x":220,
            "y":33,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,183,38);
      }
      
      override protected function initDynamicView() : void
      {
         this.creatItem();
         this.myTimeTF = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":140,
            "color":16764206,
            "size":14,
            "leading":0
         });
      }
      
      private function creatItem() : void
      {
         var posY:int = 0;
         var rangY:int = 0;
         var item:PoemsRankItem = null;
         var i:int = 0;
         this.itemArr = new Vector.<PoemsRankItem>();
         posY = 53;
         rangY = 28;
         i = 0;
         while(i < 3)
         {
            item = new PoemsRankItem();
            addChild(item);
            item.x = 43;
            item.y = posY + rangY * i;
            this.itemArr.push(item);
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = 200;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler))
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.loopHandler);
            }
         }
      }
   }
}


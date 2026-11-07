package com.yiTian.view.modules.PCU
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_pcu_status;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_PCU;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_online_award extends Panel
   {
      
      private static var _ins:View_online_award;
      
      public var receive_btns:Array;
      
      public var g_receive_btns:Array;
      
      private var instance25:ScaleBitmap;
      
      private var instance24:ScaleBitmap;
      
      private var instance26:Button;
      
      private var instance27:Bitmap;
      
      private var onlineSpr:Sprite;
      
      private var bangSpr:Sprite;
      
      private var isInit:Boolean;
      
      public function View_online_award()
      {
         super();
      }
      
      public static function get instance() : View_online_award
      {
         if(!_ins)
         {
            _ins = new View_online_award();
            _ins.init();
         }
         return _ins;
      }
      
      public static function updateAllStatus(str:String = null) : void
      {
         var i:int = 0;
         if(str == "end")
         {
            i = 0;
            while(i < 5)
            {
               instance.receive_btns[i].resetCount();
               instance.receive_btns[i].setButton(Model_PCU.onlineData[i]);
               instance.g_receive_btns[i].setButton(Model_PCU.banghuiData[i]);
               i++;
            }
            return;
         }
         i = 0;
         while(i < 5)
         {
            instance.receive_btns[i].setButton(Model_PCU.onlineData[i]);
            instance.g_receive_btns[i].setButton(Model_PCU.banghuiData[i]);
            i++;
         }
         var j:int = 0;
         while(j < 5)
         {
            if(instance.receive_btns[j].status == 0)
            {
               instance.receive_btns[j].startCount();
               break;
            }
            j++;
         }
      }
      
      public static function updateStatus(_id:int, _status:int) : void
      {
         if(_id < 5)
         {
            instance.receive_btns[_id].setButton(_status);
            if(_status == Enum_pcu_status.CAN_GET && _id < 4)
            {
               instance.receive_btns[_id + 1].startCount();
            }
            if(_status == Enum_pcu_status.HAS_GET)
            {
               instance.receive_btns[_id].flyToBag();
            }
         }
         else
         {
            instance.g_receive_btns[_id - 5].setButton(_status);
            if(_status == Enum_pcu_status.HAS_GET)
            {
               instance.g_receive_btns[_id - 5].flyToBag();
            }
         }
         var i:int = 0;
         while(i < 5)
         {
            if(Model_PCU.onlineData[i] == 1 || Model_PCU.banghuiData[i] == 1)
            {
               View_online_award_btn.instance.effectBegin();
               return;
            }
            i++;
         }
         View_online_award_btn.instance.effectEnd();
      }
      
      override protected function initStaticView() : void
      {
         var awardItem:Online_award_item = null;
         var i:int = 0;
         var j:int = 0;
         move = new Rectangle(0,0,810,36);
         this.instance25 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":810,
            "height":484
         },Global.Img_Cdm);
         this.instance24 = ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":762,
            "height":434
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":776,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.onlineSpr = new Sprite();
         this.onlineSpr.x = 34;
         this.onlineSpr.y = 50;
         addChild(this.onlineSpr);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.onlineSpr,{
            "x":0,
            "y":0,
            "width":337,
            "height":414
         },Global.Img_Cdm);
         ComponentUtil.getTextField("在21:00-21:30每在线5分钟即可领取奖励",this.onlineSpr,{
            "x":18,
            "y":42,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("注：中途下线则在线时间重新计算",this.onlineSpr,{
            "x":18,
            "y":59,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.onlineSpr,{
            "x":5,
            "y":150,
            "width":327,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.onlineSpr,{
            "x":5,
            "y":342,
            "width":327,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.onlineSpr,{
            "x":5,
            "y":278,
            "width":327,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.onlineSpr,{
            "x":5,
            "y":214,
            "width":327,
            "height":2
         },Global.Img_Cdm);
         this.receive_btns = [];
         i = 0;
         while(i < 5)
         {
            awardItem = new OnlineItem(i);
            this.onlineSpr.addChild(awardItem);
            awardItem.x = 10;
            awardItem.y = 90 + i * 64;
            this.receive_btns.push(awardItem);
            i++;
         }
         this.bangSpr = new Sprite();
         this.bangSpr.x = 381;
         this.bangSpr.y = 50;
         addChild(this.bangSpr);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this.bangSpr,{
            "x":0,
            "y":0,
            "width":395,
            "height":414
         },Global.Img_Cdm);
         ComponentUtil.getTextField("在21:00-21:30帮会在线人数达到一定比例可领取奖励",this.bangSpr,{
            "x":27,
            "y":42,
            "color":16184781,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("注：比例 = 在线人数/帮会人数上限    每分钟统计一次",this.bangSpr,{
            "x":27,
            "y":59,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.bangSpr,{
            "x":5,
            "y":150,
            "width":385,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.bangSpr,{
            "x":5,
            "y":214,
            "width":385,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.bangSpr,{
            "x":5,
            "y":278,
            "width":385,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this.bangSpr,{
            "x":5,
            "y":342,
            "width":385,
            "height":2
         },Global.Img_Cdm);
         this.g_receive_btns = [];
         j = 0;
         while(j < 5)
         {
            awardItem = new BangItem(5 + j);
            this.bangSpr.addChild(awardItem);
            awardItem.x = 10;
            awardItem.y = 90 + j * 64;
            this.g_receive_btns.push(awardItem);
            j++;
         }
      }
      
      override public function resetPosition() : void
      {
         this.x = (Global.stage.stageWidth - width) / 2;
         this.y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!this.isInit && value)
         {
            this.loadTitle();
            this.isInit = true;
         }
      }
      
      private function loadTitle() : void
      {
         var arr:Array = [];
         arr.push(["lang/ch/PCU_Imgs.swf",this.loadCom,LangConfig.getWord("10550",1),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr);
      }
      
      private function loadCom(info:Object) : void
      {
         Global.PCU_Imgsdm = info.applicationDomain;
         ComponentUtil.getBitmap("Title_PCU",this,{
            "x":325,
            "y":5
         },Global.PCU_Imgsdm);
         ComponentUtil.getBitmap("List_Online",this.onlineSpr,{
            "x":5,
            "y":5
         },Global.PCU_Imgsdm);
         ComponentUtil.getBitmap("List_Bang",this.bangSpr,{
            "x":5,
            "y":5
         },Global.PCU_Imgsdm);
         var i:int = 0;
         while(i < this.g_receive_btns.length)
         {
            this.receive_btns[i].initBm();
            this.g_receive_btns[i].initBm();
            i++;
         }
      }
   }
}


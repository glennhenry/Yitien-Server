package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_farm_farmer;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.FarmGuideManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.FarmHandler;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.friends.Model_Friends;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_farm_farmer extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _no:Bitmap;
      
      private var _clickTips:Bitmap;
      
      private var _num:Bitmap;
      
      private var head:Bitmap;
      
      private var _buffer:Sprite;
      
      private var _bufferTimeTxt:MyTextField;
      
      private var roleName:MyTextField;
      
      private var _sleep:Effect;
      
      private var vo:Vo_farm_farmer;
      
      public var position:uint;
      
      private var btnRelease:Button;
      
      private var btnReward:Button;
      
      private var _hotArea:Sprite;
      
      public function View_farm_farmer()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._bg = new Bitmap();
         this._no = new Bitmap();
         this.addChild(this._no);
         this._no.x = 0;
         this._no.y = 0;
         this._clickTips = new Bitmap();
         this.addChild(this._clickTips);
         this._clickTips.x = 12;
         this._clickTips.y = 10;
         this.head = new Bitmap();
         this.head.x = 7;
         this.head.y = 3;
         this.addChild(this.head);
         this.roleName = ComponentUtil.getTextField("",this,{
            "x":-16,
            "y":57,
            "color":8896312,
            "size":12,
            "leading":0
         });
         this.roleName.realWidth = 95;
         this.roleName.align = "center";
         this.drawHotArea();
         this.addBtn();
         this._buffer = new Sprite();
         this._buffer.x = -5;
         this._buffer.y = -6;
         this.addChild(this._buffer);
         ComponentUtil.getBitmap("farmerBuffer",this._buffer,null,Global.ShanZhuang_Imgsdm);
         this._buffer.visible = false;
         this._buffer.addEventListener(MouseEvent.MOUSE_OVER,this.onoverBuffer);
         this._buffer.addEventListener(MouseEvent.MOUSE_OUT,this.onoutBuffer);
         this._bufferTimeTxt = ComponentUtil.getTextField("",this._buffer,{
            "x":10,
            "y":20,
            "color":99999999,
            "size":12,
            "leading":0
         });
         this._bufferTimeTxt.background = true;
         this._bufferTimeTxt.backgroundColor = 1426063360;
         this._bufferTimeTxt.visible = false;
      }
      
      protected function onoutBuffer(event:MouseEvent) : void
      {
         this._bufferTimeTxt.visible = false;
      }
      
      protected function onoverBuffer(event:MouseEvent) : void
      {
         this._bufferTimeTxt.visible = true;
      }
      
      private function addBtn() : void
      {
         this.btnRelease = ComponentUtil.getButton("","Button_FangL",this,{
            "x":-25,
            "y":0,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.addChild(this.btnRelease);
         this.btnRelease.visible = false;
         this.btnRelease.addEventListener(MouseEvent.CLICK,this.onClickRelease);
         TipManager.bind(this.btnRelease,LangConfig.getWord("42",9));
         this.btnReward = ComponentUtil.getButton("","Button_ShangL",this,{
            "x":-25,
            "y":38,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.addChild(this.btnReward);
         this.btnReward.visible = false;
         this.btnReward.addEventListener(MouseEvent.CLICK,this.onClickReward);
         TipManager.bind(this.btnReward,LangConfig.getWord("43",9));
      }
      
      private function onClickReward(evt:MouseEvent) : void
      {
         var time:uint = this.vo.time_buffer_left + 3600 * 3 + 5;
         if(time > this.vo.time_left)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("203",9));
            return;
         }
         FarmCGMessage.cg_farm_reward(GameUnitManager.hero.id,this.vo.id);
      }
      
      private function onClickRelease(evt:MouseEvent) : void
      {
         var onRelease:Function = null;
         onRelease = function(evt:MouseEvent):void
         {
            FarmCGMessage.cg_farm_release(GameUnitManager.hero.id,vo.id,position);
         };
         var str:String = HtmlUtil.font(LangConfig.getWord("4",9),"#fefefe") + HtmlUtil.font(this.vo.name,ColorConstant.getColorStr(4));
         View_Alert.show(str,View_Alert.OK_CANCAL,onRelease);
      }
      
      public function hideBtn() : void
      {
         this.btnRelease.visible = false;
         this.btnReward.visible = false;
      }
      
      public function showBtn() : void
      {
         this.btnRelease.visible = true;
         this.btnReward.visible = true;
      }
      
      private function drawHotArea() : void
      {
         this._hotArea = new Sprite();
         this._hotArea.name = Model_farm.farm_master_hot_area;
         this.addChild(this._hotArea);
         this._hotArea.name = Model_farm.farm_famer_hot_area;
         this._hotArea.graphics.beginFill(65280,0);
         this._hotArea.graphics.drawRect(0,0,88,100);
         this._hotArea.graphics.endFill();
         this._hotArea.addEventListener(MouseEvent.CLICK,this.onClickHotArea);
         this._hotArea.addEventListener(MouseEvent.MOUSE_OVER,this.onOverHotArea);
         this._hotArea.addEventListener(MouseEvent.MOUSE_OUT,this.onOutHotArea);
      }
      
      private function onClickHotArea(evt:MouseEvent) : void
      {
         var vo:Vo_farm_farmer = null;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            vo = Model_farm.instace.getVoFarmerMine(this.position);
            if(!vo)
            {
               return;
            }
            if(vo.id == 0)
            {
               Model_farm.instace.catch_click_farmer_pos = this.position;
               FarmHandler.openDefeatList();
               FarmGuideManager.instance.nextStep(2);
               return;
            }
            return;
         }
         vo = Model_farm.instace.getVoFarmerOther(this.position);
      }
      
      private function onClickThis(evt:MouseEvent) : void
      {
      }
      
      private function onOverHotArea(evt:MouseEvent) : void
      {
         Model_farm.instace.farmerPositionMouse = this.position;
         if(Boolean(this.vo) && this.vo.status == Vo_farm_farmer.farmer_status_sleep)
         {
            if(Model_farm.instace.mouseType == Model_farm.mouse_type_none)
            {
               Model_farm.instace.mouseType = Model_farm.mouse_type_sleep;
            }
         }
         this.parent.setChildIndex(this,this.parent.numChildren - 1);
      }
      
      private function onOutHotArea(evt:MouseEvent) : void
      {
         Model_farm.instace.farmerPositionMouse = 0;
         if(Model_farm.instace.mouseType == Model_farm.mouse_type_sleep)
         {
            Model_farm.instace.mouseType = Model_farm.mouse_type_none;
         }
      }
      
      public function uqdate(vo:Vo_farm_farmer) : void
      {
         this.vo = vo;
         this.buttonMode = false;
         this.checkTips();
         this.updateBufferShowHide();
         if(vo == null)
         {
            if(Boolean(this._clickTips))
            {
               this._clickTips.bitmapData = null;
            }
            this.head.bitmapData = null;
            this._buffer.visible = false;
            this.roleName.text = LangConfig.getWord("5",9,this.position);
            this._no.bitmapData = ComponentUtil.getBitmapData("NongFu_Locked",Global.ShanZhuang_Imgsdm);
            this.hideBtn();
            if(this.position == Model_farm.instace.farmerPositionMouse)
            {
               if(Model_farm.instace.mouseType == Model_farm.mouse_type_sleep)
               {
                  Model_farm.instace.mouseType = Model_farm.mouse_type_none;
               }
            }
            if(Boolean(this._sleep))
            {
               EffectManager.removeEffect(this._sleep);
               this._sleep = null;
            }
            return;
         }
         if(vo.id == 0)
         {
            if(Model_farm.isMine(Model_farm.currentFarmId))
            {
               this._no.bitmapData = null;
               this._clickTips.bitmapData = ComponentUtil.getBitmapData("NongFu_Opened_click",Global.ShanZhuang_Imgsdm);
            }
            else
            {
               this._clickTips.bitmapData = null;
               this._no.bitmapData = ComponentUtil.getBitmapData("NongFu_Opened",Global.ShanZhuang_Imgsdm);
            }
            this.hideBtn();
            if(Model_farm.isMine(Model_farm.currentFarmId))
            {
               this.buttonMode = true;
            }
            this.head.bitmapData = null;
            this._buffer.visible = false;
            this.roleName.text = LangConfig.getWord("5",9,this.position);
            if(Boolean(this._sleep))
            {
               EffectManager.removeEffect(this._sleep);
               this._sleep = null;
            }
            return;
         }
         this._clickTips.bitmapData = null;
         this._no.bitmapData = null;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            this.showBtn();
         }
         var str:String = Const_strImg.getPlayerHead(Enum_job.getBaseJob(vo.profession),vo.sex,1);
         this.head = Utils.getLoadBitmap(str,this.head);
         vo.name = Model_heFu.repNameByHero(vo.name);
         this.roleName.text = vo.name;
      }
      
      public function updateBufferShowHide() : void
      {
         this.checkTips();
         if(Boolean(Model_farm.isMine(Model_farm.currentFarmId)) && Boolean(this.vo) && this.vo.time_buffer_left > 0)
         {
            this._buffer.visible = true;
         }
         else
         {
            this._buffer.visible = false;
         }
      }
      
      public function updateBufferTime() : void
      {
         if(!Model_farm.isMine(Model_farm.currentFarmId))
         {
            return;
         }
         if(!this.vo || this.vo.id == 0)
         {
            return;
         }
         var time:String = DateUtil.getHMSBySecond2(this.vo.time_buffer_left,"::");
         this._bufferTimeTxt.text = LangConfig.getWord("204",9) + time;
      }
      
      private function checkTips() : void
      {
         var needLevel:uint = 0;
         var str:String = null;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            if(Boolean(this.vo))
            {
               if(this.vo.id == 0)
               {
                  TipManager.bind(this._hotArea,LangConfig.getWord("6",9));
               }
               else
               {
                  TipManager.bind(this._hotArea,this.getFarmerTips());
               }
            }
            else
            {
               needLevel = Model_farm.farmer_num_need_farm_level[this.position];
               str = LangConfig.getWord("7",9,needLevel);
               TipManager.bind(this._hotArea,str);
            }
         }
         else
         {
            TipManager.unBind(this._hotArea);
         }
      }
      
      private function getFarmerTips() : String
      {
         if(!this.vo)
         {
            return "";
         }
         var value0:String = (this.position * 3 - 2).toString() + "-" + this.position * 3;
         var value1:String = this.getAddCount(this.vo.level);
         var value2:String = this.vo.time_buffer_left > 0 ? "90%" : "50%";
         return LangConfig.getWord("205",9,value0,value1,value2);
      }
      
      private function checkSleeping() : void
      {
         if(this.vo.status == Vo_farm_farmer.farmer_status_sleep)
         {
            if(!this._sleep)
            {
               this._sleep = EffectManager.addEffect("35110",this,500,50,30,true);
            }
         }
         else if(Boolean(this._sleep))
         {
            EffectManager.removeEffect(this._sleep);
            this._sleep = null;
         }
      }
      
      private function getAddCount(farmerLevel:uint) : String
      {
         var fvo:Vo_unit = null;
         var level:uint = 0;
         if(Model_farm.isMine(Model_farm.currentFarmId))
         {
            level = uint(GameUnitManager.hero.level);
         }
         else
         {
            fvo = Model_Friends.getFriendVoById(Model_farm.currentFarmId);
            level = uint(fvo.level);
         }
         if(level == 0)
         {
            return "0";
         }
         var value:int = farmerLevel - level;
         if(value < -5)
         {
            return "25%";
         }
         if(value >= -5 && value <= 5)
         {
            return "50%";
         }
         if(value > 5)
         {
            return "75%";
         }
         return "0";
      }
      
      public function addEffect(effect:String, totalTime:uint = 500, px:Number = 0, py:Number = 0) : void
      {
         EffectManager.addEffect(effect,this,totalTime,px,py,false);
      }
   }
}


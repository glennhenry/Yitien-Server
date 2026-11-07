package com.yiTian.gameUnit.role
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_CursorType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.CursorManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.KFHomeland.EnterHomeControl;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.baby.babyPan.BabyInBattleRule;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class NpcBaby extends Role
   {
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      public static const words:String = "爹地妈咪  点击可带我出战~-~";
      
      private var modId:uint;
      
      private var wordsTf:MyTextField;
      
      private var maskSp:Sprite;
      
      private var nameTxts:MyTextField;
      
      private var lastTime:uint;
      
      private var totalTime:uint = 800;
      
      public function NpcBaby()
      {
         super();
      }
      
      private static function checkIsCouple(name:String) : Boolean
      {
         return GameUnitManager.hero.marriageName == name;
      }
      
      public function initBaby(id:Number, modId:uint, globalX:int, globalY:int, bbName:String) : void
      {
         this.modId = modId;
         this.id = id;
         way = 3;
         global_x = globalX;
         global_y = globalY;
         setBody(Status.NOMAL,modId);
         action = Action.STAND;
         status = Status.NOMAL;
         nameBar.visible = false;
         if(!this.maskSp)
         {
            this.maskSp = new Sprite();
            this.maskSp.graphics.beginFill(0,1);
            this.maskSp.graphics.drawRect(0,0,50,20);
            this.maskSp.graphics.endFill();
            addChild(this.maskSp);
            ComponentUtil.setPropertie(this.maskSp,{
               "x":-30,
               "y":-100
            });
         }
         if(!bbName)
         {
            bbName = "子女";
         }
         if(!this.nameTxts)
         {
            this.nameTxts = ComponentUtil.getTextField(bbName,this,{
               "x":-20,
               "y":-80,
               "color":16383744
            });
         }
         this.nameTxts.htmlText = bbName;
         if(!this.wordsTf)
         {
            this.wordsTf = ComponentUtil.getTextField("爹地妈咪  点击可带我出战~-~",this,{
               "x":0,
               "y":-100,
               "color":16383744
            });
         }
         if(!this.wordsTf.mask)
         {
            this.wordsTf.mask = this.maskSp;
            ComponentUtil.setPropertie(this.wordsTf,{"x":this.maskSp.x + this.maskSp.width});
         }
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.sayWords);
         this.lastTime = getTimer();
      }
      
      private function sayWords() : void
      {
         var now:uint = uint(getTimer());
         --this.wordsTf.x;
         if(this.wordsTf.x <= this.maskSp.x - this.wordsTf.width)
         {
            this.wordsTf.x = this.maskSp.x + this.maskSp.width;
         }
      }
      
      override public function interaction(mode:int = 0) : void
      {
         if(!EnterHomeControl.instance.isMyHome() && !checkIsCouple(EnterHomeControl.homeName_ofPlayer))
         {
            UIManager.centerBroadcast.addMsg("爹地妈咪说不要和陌生人说话。。",1);
            return;
         }
         Model_baby.show(BabyInBattleRule.instance,"show",id);
      }
      
      override public function show() : void
      {
         super.show();
         list[id] = this;
      }
      
      override public function mouseOver() : void
      {
         super.mouseOver();
         CursorManager.show(Enum_CursorType.FUN_NPC);
      }
      
      override public function mouseOut() : void
      {
         super.mouseOut();
         CursorManager.hide();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         delete list[id];
         pool.push(this);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.sayWords);
      }
   }
}


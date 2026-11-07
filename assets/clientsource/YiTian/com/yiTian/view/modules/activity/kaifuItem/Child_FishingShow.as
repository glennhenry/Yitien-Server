package com.yiTian.view.modules.activity.kaifuItem
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_FishingShow extends Sprite
   {
      
      private var initPoint:Vector.<Point> = new Vector.<Point>();
      
      private var selectedIndex:int;
      
      private var modelVec:Vector.<Child_tianTiUnit> = new Vector.<Child_tianTiUnit>();
      
      private var isPlay:Boolean;
      
      private var num:int;
      
      private var txt:MyTextField;
      
      private var timeFlag:Array = [];
      
      public function Child_FishingShow()
      {
         super();
         this.initPoint.push(new Point(320,150));
         this.initPoint.push(new Point(460,150));
         this.initPoint.push(new Point(390,150));
         this.initPoint.push(new Point(250,150));
         this.initUI();
      }
      
      private function initUI() : void
      {
         var _modelRole:Child_tianTiUnit = null;
         var hero:Hero = null;
         var i:int = 0;
         var effect:Effect = EffectManager.addEffect("35016",this,1500,515,205,true);
         effect.scaleX = 0.5;
         effect.scaleY = 0.7;
         this.txt = ComponentUtil.getTextField("时装碎片可在时装大使处兑换时装",this,{
            "x":210,
            "y":180,
            "bold":true,
            "color":327424,
            "size":18
         });
         i = 0;
         while(i < 4)
         {
            _modelRole = new Child_tianTiUnit();
            _modelRole.type = Child_tianTiUnit.PLAYER;
            _modelRole.x = this.initPoint[i].x;
            _modelRole.y = this.initPoint[i].y;
            _modelRole.scaleX = _modelRole.scaleY = 1;
            _modelRole.way = 4;
            addChild(_modelRole);
            _modelRole.setFrameInterval(150);
            _modelRole.updateLayer();
            hero = GameUnitManager.hero;
            _modelRole.sex = hero.sex;
            _modelRole.job = hero.job;
            _modelRole.modelId = Enum_KF.FISHINGID[hero.sex][i];
            _modelRole.updateLayer();
            this.modelVec.push(_modelRole);
            if(_modelRole.x == this.initPoint[0].x && _modelRole.y == this.initPoint[0].y)
            {
               _modelRole.scaleX = _modelRole.scaleY = 1.2;
               _modelRole.filters = [];
            }
            else
            {
               _modelRole.scaleX = _modelRole.scaleY = 1;
            }
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,_modelRole.onFrame);
            i++;
         }
         this.num = this.numChildren - 1;
         this.setChildIndex(this.modelVec[0],this.num);
      }
      
      private function play() : void
      {
         var time:int = 0;
         var a:int = 0;
         var i:int = 0;
         var ff:Function = null;
         var doEff:Function = null;
         ff = function():void
         {
            if(i == 3)
            {
               return;
            }
            a = setTimeout(ff,time + 1000,i);
            timeFlag.push(a);
            disAble();
            setIndex(modelVec[0],(i + 1) % 4);
            Tween.to(modelVec[0],time,{
               "x":[modelVec[0].x,initPoint[(i + 1) % 4].x],
               "y":[modelVec[0].y,initPoint[(i + 1) % 4].y]
            },doEff);
            setIndex(modelVec[1],(i + 2) % 4);
            Tween.to(modelVec[1],time,{
               "x":[modelVec[1].x,initPoint[(i + 2) % 4].x],
               "y":[modelVec[1].y,initPoint[(i + 2) % 4].y]
            },doEff);
            setIndex(modelVec[2],(i + 3) % 4);
            Tween.to(modelVec[2],time,{
               "x":[modelVec[2].x,initPoint[(i + 3) % 4].x],
               "y":[modelVec[2].y,initPoint[(i + 3) % 4].y]
            },doEff);
            setIndex(modelVec[3],(i + 4) % 4);
            Tween.to(modelVec[3],time,{
               "x":[modelVec[3].x,initPoint[i % 4].x],
               "y":[modelVec[3].y,initPoint[i % 4].y]
            },doEff);
            ++i;
         };
         doEff = function(_modelRole:Child_tianTiUnit):void
         {
            if(_modelRole.x == initPoint[0].x)
            {
               Tween.to(_modelRole,1000,{
                  "scaleX":[1,1.2],
                  "scaleY":[1,1.2]
               },function(_modelRole:Child_tianTiUnit):void
               {
                  var _temp_1:* = _modelRole;
                  _modelRole.scaleY = 1;
                  _temp_1.scaleX = 1;
               });
               _modelRole.filters = [];
               _modelRole.parent.setChildIndex(_modelRole,num);
            }
            else
            {
               var _temp_1:* = _modelRole;
               _modelRole.scaleY = 1;
               _temp_1.scaleX = 1;
            }
         };
         var disAble:Function = function():void
         {
            var _modelRole:Child_tianTiUnit = null;
            var i:int = 0;
            while(i < 4)
            {
               _modelRole = modelVec[i];
               var _temp_1:* = _modelRole;
               _modelRole.scaleY = 1;
               _temp_1.scaleX = 1;
               i++;
            }
         };
      }
      
      private function setIndex(_modelRole:Child_tianTiUnit, algin:int) : void
      {
         var index:int = 0;
         switch(algin)
         {
            case 0:
               index = this.numChildren - 1;
               break;
            case 1:
               index = this.numChildren - 2;
               break;
            case 2:
               index = this.numChildren - 4;
               break;
            case 3:
               index = this.numChildren - 3;
         }
         _modelRole.parent.setChildIndex(_modelRole,index);
      }
      
      private function reset() : void
      {
         var _modelRole:Child_tianTiUnit = null;
         var i:int = 0;
         this.isPlay = false;
         i = 0;
         while(i < 4)
         {
            _modelRole = this.modelVec[i];
            _modelRole.type = Child_tianTiUnit.PLAYER;
            _modelRole.x = this.initPoint[i].x;
            _modelRole.y = this.initPoint[i].y;
            _modelRole.scaleX = _modelRole.scaleY = 1;
            _modelRole.scaleX = _modelRole.scaleY = 1;
            i++;
         }
         var ii:int = 0;
         while(ii < this.timeFlag.length)
         {
            clearTimeout(this.timeFlag[ii]);
            ii++;
         }
         this.timeFlag = [];
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         var i:int = 0;
         while(i < 4)
         {
            if(value)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.modelVec[i].onFrame);
               if(!this.isPlay)
               {
                  this.play();
               }
               else
               {
                  this.reset();
                  this.play();
               }
            }
            else
            {
               this.reset();
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.modelVec[i].onFrame);
            }
            i++;
         }
      }
   }
}


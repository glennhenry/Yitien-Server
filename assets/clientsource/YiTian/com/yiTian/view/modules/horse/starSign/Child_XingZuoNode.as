package com.yiTian.view.modules.horse.starSign
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.vo.Vo_XingZuoStar;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HorseCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.horse.Model_horse;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_XingZuoNode extends Sprite
   {
      
      public static var gra:Graphics;
      
      private static var pool:Array = [];
      
      private var _vo:Vo_XingZuoStar = new Vo_XingZuoStar();
      
      private var _eff:Effect;
      
      public var index:int;
      
      public var childs:Array = [];
      
      public var id:int;
      
      private var _percent:Number = 0;
      
      protected var _parent:Child_XingZuoNode;
      
      public function Child_XingZuoNode()
      {
         super();
         buttonMode = true;
         var bm:Bitmap = ComponentUtil.getBitmap("Icon_XZDL",this,{
            "x":-19.5,
            "y":-19.5
         },Global.XingZuodm);
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
         addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      public static function getNode() : Child_XingZuoNode
      {
         return new Child_XingZuoNode();
      }
      
      private function rollOverHandler(e:MouseEvent) : void
      {
         this._vo.index = this.id;
         TipManager.update(this._vo);
      }
      
      private function rollOutHandler(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function setState(st:int) : void
      {
         if(st == 1)
         {
            if(!this._eff)
            {
               this._eff = EffectManager.addEffect("35341",this,1000,0,0,true);
            }
            filters = null;
         }
         else if(st == 0)
         {
            if(Boolean(this._eff))
            {
               EffectManager.removeEffect(this._eff);
               this._eff = null;
            }
            filters = Util.disabled;
         }
      }
      
      private function clickHandler(e:MouseEvent) : void
      {
         var lv:int;
         var minPartLv:int;
         var needPartLv:int;
         if(this.id <= Model_XingZuo.curSignIndex)
         {
            UIManager.centerBroadcast.addMsg("该星点已激活",1);
            return;
         }
         lv = Model_XingZuo.signLevel;
         minPartLv = Model_horse.getSSLevel();
         needPartLv = int(Data_lib.xingZuo[lv][Enum_xingZuo.LIB_XZ_PARTLVNEED]);
         if(minPartLv < needPartLv)
         {
            UIManager.centerBroadcast.addMsg(Util.rep("坐骑全体部件未达{0}级",needPartLv),1);
            return;
         }
         if(Model_XingZuo.xingLei < Data_lib.xingZuoStar[this.id][Enum_xingZuo.LIB_COST_XINGLEI])
         {
            View_Alert.show("所需星泪不足,前往商城可以购买星泪瓶",View_Alert.OK_CANCAL,function():void
            {
               var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
               pan.setItemEff(45470,true);
               pan.openView(0,3);
            });
            return;
         }
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < Data_lib.xingZuoStar[this.id][Enum_xingZuo.LIB_COST_SILVER])
         {
            UIManager.centerBroadcast.addMsg("激活该星点所需银两不足",1);
            return;
         }
         HorseCGMessage.CG_ENABLE_STARGIGN();
      }
      
      override public function set x(value:Number) : void
      {
         super.x = value;
      }
      
      override public function set y(value:Number) : void
      {
         super.y = value;
      }
      
      public function addNode(child:Child_XingZuoNode) : void
      {
         child.index = this.index + 1;
         if(Boolean(child._parent))
         {
            child._parent.removeNode(child);
         }
         child._parent = this;
         this.childs.push(child);
      }
      
      public function removeNode(child:Child_XingZuoNode) : void
      {
         var index:int = this.childs.indexOf(child);
         if(index != -1)
         {
            this.childs.splice(index,1);
         }
      }
      
      public function drawLine(isDrawChild:Boolean = false, isDrawParent:Boolean = false) : void
      {
         var child:Child_XingZuoNode = null;
         var angle:Number = NaN;
         var len:Number = NaN;
         var xx:Number = NaN;
         var yy:Number = NaN;
         if(isDrawParent && Boolean(this._parent))
         {
            this._parent.drawLine(false,true);
         }
         for each(child in this.childs)
         {
            angle = -Math.atan2(child.x - x,child.y - y) + Math.PI / 2;
            len = Math.sqrt(Util.dist(x,y,child.x,child.y));
            xx = x + len * Math.cos(angle) * this._percent;
            yy = y + len * Math.sin(angle) * this._percent;
            gra.moveTo(x,y);
            gra.lineStyle(3,3386111);
            gra.lineTo(xx,yy);
            gra.endFill();
            if(this._percent < 1)
            {
               gra.moveTo(xx,yy);
               gra.lineStyle(1,10066329);
               gra.lineTo(x + len * Math.cos(angle),y + len * Math.sin(angle));
            }
            if(isDrawChild)
            {
               child.drawLine(true,false);
            }
         }
      }
      
      public function set drawPercent(v:Number) : void
      {
         this._percent = v;
      }
      
      public function get drawPercent() : Number
      {
         return this._percent;
      }
      
      public function get nodeParent() : Child_XingZuoNode
      {
         return this._parent;
      }
      
      public function get numNodeChild() : uint
      {
         return this.childs.length;
      }
      
      public function dispose() : void
      {
         var child:Child_XingZuoNode = null;
         for each(child in this.childs)
         {
            child.dispose();
         }
         this.childs.length = 0;
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         this._parent = null;
         pool.push(this);
      }
      
      public function buildDelphi(len:int) : void
      {
         var child:Child_XingZuoNode = null;
         len--;
         this._percent = 0;
         if(len > 0)
         {
            if(!this.childs.length)
            {
               child = Child_XingZuoNode.getNode();
               child.graphics.clear();
               this.addNode(child);
            }
            this.childs[0].buildDelphi(len);
         }
      }
      
      public function getChildsDepth() : uint
      {
         var curNode:Child_XingZuoNode = this;
         while(Boolean(curNode.childs.length))
         {
            curNode = curNode.childs[0];
         }
         return curNode.index;
      }
      
      public function clearChildAtDepth(startDepth:uint) : void
      {
         var child:Child_XingZuoNode = null;
         var curNode:Child_XingZuoNode = this;
         while(Boolean(curNode.childs.length))
         {
            curNode = curNode.childs[0];
            if(startDepth == curNode.index)
            {
               for each(child in curNode.childs)
               {
                  child.dispose();
               }
               curNode.childs.length = 0;
               break;
            }
         }
      }
   }
}


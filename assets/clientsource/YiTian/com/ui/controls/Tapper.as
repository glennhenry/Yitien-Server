package com.ui.controls
{
   import Layout.HGroup;
   import Layout.ILayout;
   import Layout.VGroup;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Event(name="tapper_change",type="com.ui.controls.TapperEvent")]
   [Event(name="tapper_add",type="com.ui.controls.TapperEvent")]
   public class Tapper extends Sprite
   {
      
      protected var _tapLayer:Sprite;
      
      protected var _tapFactory:AbstractFactoryBase;
      
      protected var _tapLayout:ILayout;
      
      protected var _contentLayout:ILayout;
      
      protected var _tapers:Array = [];
      
      protected var _stage:Stage;
      
      protected var _contentLayer:Sprite;
      
      protected var _lastChooseIndex:int = -1;
      
      public function Tapper(fac:AbstractFactoryBase, $stage:Stage, tapperLay:ILayout = null, outLayer:ILayout = null)
      {
         super();
         this._contentLayer = new Sprite();
         addChild(this._contentLayer);
         this._tapLayer = new Sprite();
         addChild(this._tapLayer);
         this.tabFactory = fac;
         this._stage = $stage;
         this._tapLayout = tapperLay || new VGroup(0,0,0,0,0,80);
         this.outLay = outLayer || new HGroup(0,0,0,0,0,22);
         this.outLay.appendSomeItem(this._tapLayer,this._contentLayer);
      }
      
      public function set tabFactory(fac:AbstractFactoryBase) : void
      {
         this._tapFactory = fac;
      }
      
      public function get tabFactory() : AbstractFactoryBase
      {
         return this._tapFactory;
      }
      
      public function set tapBtnsLay(lay:ILayout) : void
      {
         this._tapLayout = lay;
         this.invalidate();
      }
      
      public function get tapBtnsLay() : ILayout
      {
         return this._tapLayout;
      }
      
      public function set outLay(lay:ILayout) : void
      {
         this._contentLayout = lay;
         this.invalidate();
      }
      
      public function get outLay() : ILayout
      {
         return this._contentLayout;
      }
      
      public function appendTapper(info:*, content:DisplayObject) : void
      {
         this.insertTapper(info,content,-1);
      }
      
      public function removeTapper(index:int) : void
      {
         var infos:Array = this._tapers[index];
         if(Boolean(infos))
         {
            this._tapLayer.removeChild(infos[0] as DisplayObject);
            this._tapLayout.dependItem(infos[0]);
            if(this._contentLayer.contains(infos[2] as DisplayObject))
            {
               this._contentLayer.removeChild(infos[2] as DisplayObject);
            }
            this._tapers.splice(index,1);
         }
         this.invalidate();
      }
      
      public function clear() : void
      {
         var i:int = this._tapers.length - 1;
         while(i >= 0)
         {
            this.removeTapper(i);
            i -= 1;
         }
      }
      
      public function insertTapper(info:*, content:DisplayObject, index:int) : void
      {
         var tap:ITap = null;
         this.fireTapperEvent(TapperEvent.CHANGE,[tap,info,content]);
         tap = this._tapFactory.createEntityObj(info);
         if(index == -1)
         {
            index = int(this._tapers.length);
         }
         this._tapers.splice(index,0,[tap,info,content]);
         this._tapLayout.appendItem(tap);
         tap.tappIndex = this._tapers.length;
         tap.tChoose = false;
         content.visible = false;
         tap.addEventListener(MouseEvent.CLICK,this.onTapperClickHd);
         this._tapLayer.addChild(tap as DisplayObject);
         this._contentLayer.addChild(content);
         this.fireTapperEvent(TapperEvent.CHANGE,tap);
         this.invalidate();
      }
      
      protected function onTapperClickHd(e:MouseEvent) : void
      {
         var tap:ITap = e.target as ITap;
         var index:int = this.getTapperIndex(tap);
         this.setSelectedIndex(index);
      }
      
      public function getTapperIndex(tap:ITap) : int
      {
         var i:int = 0;
         while(i < this._tapers.length)
         {
            if(this._tapers[i][0] == tap)
            {
               return i;
            }
            i += 1;
         }
         return -1;
      }
      
      public function setSelectedIndex(v:int) : void
      {
         var old:DisplayObject = null;
         var dobj:DisplayObject = null;
         v = Math.min(v,this._tapers.length - 1);
         if(v < 0)
         {
            return;
         }
         var b:Boolean = true;
         if(this._lastChooseIndex >= 0)
         {
            old = this._tapers[this._lastChooseIndex][2];
            if(old.hasOwnProperty("tapperHideMethod"))
            {
               false;
               b = Boolean(old["tapperHideMethod"](this._tapers[v][1]));
            }
         }
         if(v >= 0)
         {
            dobj = this._tapers[v][2];
            if(dobj.hasOwnProperty("tapperShowMethod"))
            {
               b &&= Boolean(dobj["tapperShowMethod"](this._tapers[v][1]));
            }
         }
         if(b)
         {
            if(this._lastChooseIndex >= 0)
            {
               (this._tapers[this._lastChooseIndex][0] as ITap).tChoose = false;
               old.visible = false;
            }
            (this._tapers[v][0] as ITap).tChoose = true;
            dobj.visible = true;
         }
         this._lastChooseIndex = v;
      }
      
      public function invalidate() : void
      {
         this._stage.invalidate();
         this._stage.addEventListener(Event.RENDER,this.reRender);
      }
      
      protected function reRender() : void
      {
         this._stage.removeEventListener(Event.RENDER,arguments.callee);
         this._contentLayout.align();
         this._tapLayout.align();
      }
      
      public function fireTapperEvent(type:String, param:* = null) : void
      {
         var e:TapperEvent = new TapperEvent(type);
         e.param = param;
         dispatchEvent(e);
      }
   }
}


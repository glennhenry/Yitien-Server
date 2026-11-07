package view
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DmManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import manager.MassLoader;
   
   public class OffLineTip extends Sprite
   {
      
      public static var isInit:Boolean;
      
      public static var isFengHao:Boolean;
      
      private static var _instance:OffLineTip;
      
      private var txt:MyTextField;
      
      private var back:Shape;
      
      private var bm:Bitmap;
      
      private var _linkEvent:Function;
      
      private const W:int = 560;
      
      private const H:int = 288;
      
      public function OffLineTip()
      {
         super();
      }
      
      public static function getInstance() : OffLineTip
      {
         if(!_instance)
         {
            isInit = true;
            _instance = new OffLineTip();
            _instance.init();
         }
         return _instance;
      }
      
      public function init() : void
      {
         this.back = new Shape();
         this.back.graphics.beginFill(0,0.5);
         this.back.graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
         this.back.graphics.endFill();
         addChild(this.back);
         if(Boolean(DmManager.guideMMdm))
         {
            this.bm = ComponentUtil.getBitmap("guideBg",this,null,DmManager.guideMMdm);
         }
         else
         {
            this.bm = new Bitmap();
            addChild(this.bm);
            MassLoader.add("lang/ch/guideMM.swf",function(info:Object):void
            {
               DmManager.guideMMdm = info.applicationDomain;
               bm.bitmapData = ComponentUtil.getBitmapData("guideBg",DmManager.guideMMdm);
            },null,MassLoader.LEVEL1);
         }
         this.txt = ComponentUtil.getTextField(Model_initStr.OFFLINETIP,this,{
            "realWidth":280,
            "wordWrap":true,
            "multiline":true,
            "leading":2
         });
         this.txt.selectable = true;
         this.txt.mouseEnabled = true;
         this.txt.addEventListener(TextEvent.LINK,this.linkEvent);
      }
      
      protected function linkEvent(e:TextEvent) : void
      {
         if(this._linkEvent != null)
         {
            this._linkEvent();
         }
      }
      
      public function show(info:String, linkEvent:Function = null) : void
      {
         if(OffLineTip.isFengHao)
         {
            return;
         }
         this.txt.htmlText = info;
         this._linkEvent = linkEvent;
         Global.stage.addChild(_instance);
         stopDrag();
         this.resize();
      }
      
      public function resize() : void
      {
         this.back.width = Global.stage.stageWidth;
         this.back.height = Global.stage.stageHeight;
         if(Boolean(this.bm))
         {
            this.bm.x = (Global.stage.stageWidth - this.W) / 2;
            this.bm.y = (Global.stage.stageHeight - this.H) / 2;
            this.txt.x = this.bm.x + 255;
            this.txt.y = this.bm.y + 145;
         }
      }
   }
}


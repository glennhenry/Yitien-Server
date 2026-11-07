package com.yiTian.view.modules.actions.ciRiLibao.tomorrDayGf
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class TomDayGift extends Panel123
   {
      
      public static var itemVec:Vector.<Child_tomDaygf> = new Vector.<Child_tomDaygf>();
      
      public static var isVisible:Boolean = false;
      
      private var unit:Child_tianTiUnit;
      
      private var bmp:Bitmap;
      
      private var tab1:TabButton;
      
      private var tab2:TabButton;
      
      private var con1:Sprite = new Sprite();
      
      private var con2:Sprite = new Sprite();
      
      private var b1:Bitmap;
      
      private var b2:Bitmap;
      
      private var b3:Bitmap;
      
      private var b4:Bitmap;
      
      private var b5:Bitmap;
      
      private var b6:Bitmap;
      
      private var now:TabButton;
      
      public function TomDayGift()
      {
         super();
         regResource("lang/ch/DLYL.swf","DLYLdm");
      }
      
      public static function get instance() : TomDayGift
      {
         return Singleton.getInstance(TomDayGift);
      }
      
      override protected function initUI2() : void
      {
         var item:Child_tomDaygf = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":839,
            "height":491
         },Global.Img_Cdm);
         move = new Rectangle(0,0,839,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":789,
            "height":441
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_DLYL",this,{
            "x":339,
            "y":5
         },Global.DLYLdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":804,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_DLYL",this,{
            "x":37,
            "y":52
         },Global.DLYLdm);
         this.b4 = ComponentUtil.getBitmap("Back_DLDL1",this,{
            "x":553,
            "y":52
         },Global.DLYLdm);
         this.b5 = ComponentUtil.getBitmap("Ren" + GameUnitManager.hero.sex,this,{
            "x":553 + 65,
            "y":52 + 84,
            "visible":false
         },Global.DLYLdm);
         this.tab1 = ComponentUtil.getTabButton("第二天","TabButton_Four",this,{
            "x":563,
            "y":59,
            "textColor":16772813,
            "chooseColor":16771436,
            "tabIndex":1
         },Global.Img_Cdm);
         this.tab2 = ComponentUtil.getTabButton("第七天","TabButton_Four",this,{
            "x":640,
            "y":59,
            "textColor":16772813,
            "chooseColor":16771436,
            "tabIndex":2
         },Global.Img_Cdm);
         this.tab1.addEventListener(MouseEvent.CLICK,this.tabChanged);
         this.tab2.addEventListener(MouseEvent.CLICK,this.tabChanged);
         addChild(this.con1);
         addChild(this.con2);
         this.b1 = ComponentUtil.getBitmap("ttbmp_1",this.con1,{
            "x":564,
            "y":95
         },Global.DLYLdm);
         this.b2 = ComponentUtil.getBitmap("zzbmp_1",this.con2,{
            "x":674,
            "y":439
         },Global.DLYLdm);
         this.b6 = ComponentUtil.getBitmap("Text_JKMFLQ",this.con2,{
            "x":586,
            "y":410
         },Global.DLYLdm);
         this.b3 = new Bitmap();
         addChild(this.b3);
         ComponentUtil.setPropertie(this.b3,{
            "x":611,
            "y":388
         });
         this.bmp = ComponentUtil.getBitmap("JNHNO_1",this.con2,{
            "x":640,
            "y":410
         },Global.DLYLdm);
         var i:int = 0;
         while(i < 7)
         {
            item = new Child_tomDaygf();
            item.day = i + 1;
            ComponentUtil.getBitmap("Linght_DLYL",this,{
               "x":37,
               "y":64 + 58 * i
            },Global.DLYLdm);
            addChild(item);
            ComponentUtil.setPropertie(item,{
               "x":45,
               "y":54 + i * 58
            });
            itemVec.push(item);
            i++;
         }
         var hero:Hero = GameUnitManager.hero;
         this.unit = new Child_tianTiUnit();
         this.unit.x = 674;
         this.unit.y = 332;
         addChild(this.unit);
         super.initDynamicView();
         this.initData();
         this.tab1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function tabChanged(e:MouseEvent) : void
      {
         this.showV(e.target.tabIndex);
      }
      
      private function showV(type:int = 1) : void
      {
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         this.b4.bitmapData = ComponentUtil.getBitmapData("Back_DLDL" + type,Global.DLYLdm);
         if(type == 1)
         {
            this.unit.setFrameInterval(100);
            this.unit.type = Child_tianTiUnit.HORSE;
            this.unit.modelId = 24510;
            this.unit.way = 3;
            this.unit.state = 1;
            this.b2.visible = true;
            this.unit.visible = true;
            this.b6.visible = true;
            this.b5.visible = false;
            this.bmp.visible = true;
            this.b3.visible = true;
            if(Vo_tomorrDaygf.statusDic[2] == -1 || Vo_tomorrDaygf.statusDic[2] == 0)
            {
               if(Vo_tomorrDaygf.statusDic[2] == -1)
               {
                  this.b3.bitmapData = ComponentUtil.getBitmapData("Back_YLQ",Global.DLYLdm);
               }
               else
               {
                  this.b3.bitmapData = ComponentUtil.getBitmapData("Back_KLQ",Global.DLYLdm);
               }
               this.con2.visible = false;
               this.b3.visible = this.b3.visible || true;
            }
            else
            {
               this.b3.visible = false;
               this.con2.visible = true;
               this.bmp.bitmapData = ComponentUtil.getBitmapData("JNHNO_" + Vo_tomorrDaygf.statusDic[2],Global.DLYLdm);
            }
         }
         else
         {
            this.unit.visible = false;
            this.b3.visible = false;
            this.b2.visible = false;
            this.bmp.visible = false;
            this.b6.visible = false;
            this.b5.visible = true;
         }
         this.unit.updateViewer();
         this.now = this["tab" + type];
         this.now.choose = true;
         this.b1.bitmapData = ComponentUtil.getBitmapData("ttbmp_" + type,Global.DLYLdm);
         this.b2.bitmapData = ComponentUtil.getBitmapData("zzbmp_" + type,Global.DLYLdm);
      }
      
      private function initData() : void
      {
         var day:int = 0;
         var data:String = null;
         var vo_tomorr:Vo_tomorrDaygf = null;
         var ss:String = null;
         var arr:Array = Data_lib.ciRiLibao.toArray();
         var len:int = int(arr.length);
         var sex:int = GameUnitManager.hero.sex;
         var i:int = 0;
         while(i < len)
         {
            day = int(arr[i][0]);
            data = arr[i][1];
            if(arr[i][2] != 0)
            {
               ss = (arr[i][2] as String).indexOf(",") == -1 ? arr[i][2] : arr[i][2].split(",")[sex - 1];
               data += "," + ss;
            }
            vo_tomorr = new Vo_tomorrDaygf();
            vo_tomorr.day = day;
            vo_tomorr.init(data);
            i++;
         }
         this.initItem();
      }
      
      private function initItem() : void
      {
         var key:String = null;
         var day:int = 0;
         var voTom:Vo_tomorrDaygf = null;
         var item:Child_tomDaygf = null;
         for(key in Vo_tomorrDaygf.data)
         {
            day = int(key);
            voTom = Vo_tomorrDaygf.data[key];
            item = itemVec[day - 1];
            item.initItem(voTom);
         }
      }
      
      public function update(dArr:Array) : void
      {
         var key:String = null;
         var day:int = 0;
         var voTom:Vo_tomorrDaygf = null;
         var item:Child_tomDaygf = null;
         for(key in Vo_tomorrDaygf.data)
         {
            day = int(key);
            voTom = Vo_tomorrDaygf.data[key];
            item = itemVec[day - 1];
            item.update(Vo_tomorrDaygf.statusDic[day]);
         }
         if(Vo_tomorrDaygf.statusDic[2] == -1)
         {
            this.tab2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = isVisible = value;
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
            ActionsCGMessage.CG_OPEN_CIRI_GF();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
      }
      
      private function onFrame(intereval:int) : void
      {
         this.unit.onFrame(intereval);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 835) / 2;
         y = (Global.stage.stageHeight - 490) / 2;
      }
   }
}


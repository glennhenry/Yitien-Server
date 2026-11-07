package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_farmList;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   
   public class Child_arrest_item extends Sprite
   {
      
      private static var _instance:Child_arrest_item;
      
      private var bm_icon:Bitmap;
      
      private var tf_friendName:MyTextField;
      
      private var roleLevel:MyTextField;
      
      private var status:MyTextField;
      
      private var faction:MyTextField;
      
      private var Button_Arrest:Button;
      
      private var vo_info:Vo_farmList;
      
      private var mater:MyTextField;
      
      private var sp:Sprite;
      
      private var lastTime:uint;
      
      public function Child_arrest_item()
      {
         super();
         ComponentUtil.getScaleBitmap("ListBack_Bule02",[12,12,1,1],this,{
            "x":0,
            "y":0,
            "width":332,
            "height":84
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{
            "x":15,
            "y":15,
            "width":54,
            "height":54
         },Global.Img_Cdm);
         this.Button_Arrest = ComponentUtil.getButton("","Button_Green",this,{
            "x":245,
            "y":28,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.bm_icon = new Bitmap();
         this.tf_friendName = ComponentUtil.getTextField("",this,{
            "x":75,
            "y":14,
            "color":12537400,
            "size":12,
            "leading":0
         });
         this.roleLevel = ComponentUtil.getTextField("",this,{
            "x":192,
            "y":14,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.status = ComponentUtil.getTextField("",this,{
            "x":75,
            "y":32,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.faction = ComponentUtil.getTextField("",this,{
            "x":75,
            "y":50,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.mater = ComponentUtil.getTextField("",this,{
            "x":116,
            "y":32,
            "color":8896312,
            "size":12,
            "leading":0
         });
         this.mater.visible = false;
         this.mater.addEventListener(TextEvent.LINK,this.linkHandler);
         this.sp = new Sprite();
         this.bm_icon.y = 16;
         this.bm_icon.x = 16;
         this.sp.addChild(this.bm_icon);
         addChild(this.sp);
         this.sp.buttonMode = true;
         this.Button_Arrest.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.sp.addEventListener(MouseEvent.CLICK,this.lookHandle);
      }
      
      public static function instance() : Child_arrest_item
      {
         if(!_instance)
         {
            _instance = new Child_arrest_item();
         }
         return _instance;
      }
      
      public function update(data:Vo_farmList) : void
      {
         var name:String = null;
         data.name = Model_heFu.repNameByHero(data.name);
         this.vo_info = data;
         var icon_num:int = 23000 + this.vo_info.job * 100 + 10 + this.vo_info.sex;
         var str_icon:String = "resource/image/icon/" + icon_num.toString() + ".jpg";
         Utils.getLoadBitmap(str_icon,this.bm_icon);
         this.tf_friendName.htmlText = HtmlUtil.font(this.vo_info.name,ColorConstant.getColorStr(ColorConstant.WHITE),12);
         this.roleLevel.htmlText = "Lv " + this.vo_info.level.toString();
         if(this.vo_info.faction == "")
         {
            this.vo_info.faction = LangConfig.getWord("191",9);
         }
         this.faction.htmlText = LangConfig.getWord("192",9) + this.vo_info.faction;
         if(this.vo_info.masterID == 0)
         {
            this.Button_Arrest.label = LangConfig.getWord("41",9);
            this.Button_Arrest.name = "1";
            this.status.htmlText = LangConfig.getWord("193",9);
            this.mater.visible = false;
            this.Button_Arrest.filters = null;
            this.Button_Arrest.mouseEnabled = true;
         }
         else if(data.masterID == GameUnitManager.hero.id)
         {
            this.mater.visible = true;
            name = HtmlUtil.createLink(data.masterName,true,"roleInfo");
            this.mater.htmlText = name;
            this.mater.alpha = 0;
            this.mater.mouseEnabled = true;
            this.status.htmlText = LangConfig.getWord("194",9,this.mater.htmlText);
            this.Button_Arrest.label = LangConfig.getWord("41",9);
            this.Button_Arrest.name = "1";
            this.Button_Arrest.filters = Util.disabled;
            this.Button_Arrest.mouseEnabled = false;
         }
         else
         {
            this.mater.visible = true;
            name = HtmlUtil.createLink(data.masterName,true,"roleInfo");
            this.mater.htmlText = name;
            this.mater.alpha = 0;
            this.mater.mouseEnabled = true;
            this.status.htmlText = LangConfig.getWord("194",9,this.mater.htmlText);
            this.Button_Arrest.label = LangConfig.getWord("47",9);
            this.Button_Arrest.name = "2";
            this.Button_Arrest.filters = null;
            this.Button_Arrest.mouseEnabled = true;
         }
         if(this.vo_info.id == Model_farm.instace.masterBasic_mine.captor)
         {
            this.Button_Arrest.label = LangConfig.getWord("46",9);
            this.Button_Arrest.name = "3";
         }
         if(GameUnitManager.hero.level - this.vo_info.level >= 10)
         {
            this.Button_Arrest.filters = Util.disabled;
         }
      }
      
      private function clickHandle(event:MouseEvent) : void
      {
         var value:uint = 0;
         var btn:Button = event.target as Button;
         if(GameUnitManager.hero.level - this.vo_info.level >= 10)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("128",9));
            return;
         }
         if(int(btn.name) == 1)
         {
            value = 1;
            FarmCGMessage.cg_farm_catch_farmer(GameUnitManager.hero.id,this.vo_info.id,0,value,Model_farm.instace.catch_click_farmer_pos);
         }
         else if(int(btn.name) == 2)
         {
            value = 2;
            FarmCGMessage.cg_farm_catch_farmer(GameUnitManager.hero.id,this.vo_info.id,0,value,Model_farm.instace.catch_click_farmer_pos);
         }
         else if(int(btn.name) == 3)
         {
            FarmCGMessage.cg_farm_resist(GameUnitManager.hero.id,Model_farm.instace.masterBasic_mine.captor);
         }
         this.Button_Arrest.mouseEnabled = false;
         this.lastTime = getTimer();
         this.addEventListener(Event.ENTER_FRAME,this.frameHandle);
      }
      
      private function frameHandle(event:Event) : void
      {
         var nowTime:uint = uint(getTimer());
         if(int(nowTime - this.lastTime) / 1000 >= 5)
         {
            this.Button_Arrest.mouseEnabled = true;
         }
      }
      
      private function lookHandle(event:MouseEvent) : void
      {
         RoleCGMessage.CG_CHECK_OTHERROLE(this.vo_info.id);
      }
      
      private function linkHandler(event:TextEvent) : void
      {
         if(this.vo_info.masterID != 0)
         {
            RoleCGMessage.CG_CHECK_OTHERROLE(this.vo_info.masterID);
         }
      }
      
      public function dispose() : void
      {
         this.vo_info = null;
         this.tf_friendName.htmlText = "";
         this.bm_icon.bitmapData = null;
         this.roleLevel.htmlText = "";
         this.status.htmlText = "";
         this.faction.htmlText = "";
      }
   }
}


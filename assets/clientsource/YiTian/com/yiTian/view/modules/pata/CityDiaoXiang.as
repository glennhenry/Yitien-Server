package com.yiTian.view.modules.pata
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class CityDiaoXiang extends Role
   {
      
      public static var pool:Array = [];
      
      public static var list:Dictionary = new Dictionary();
      
      public var diaoXiangType:int;
      
      public var heroId:Number = 0;
      
      public var heroName:String;
      
      public var shiZhuang:int;
      
      public var wuQi:int;
      
      public var bangHuiMC:String;
      
      public var bangHuiZW:int;
      
      public var chaoXiang:int;
      
      public var xc:int;
      
      public var yc:int;
      
      public var equipArr:Array;
      
      public var stoneLvl:int;
      
      public var ringId:int;
      
      public var qinmiDu:int;
      
      public var vipLevel:int;
      
      public var couple_other_name:String = "夫妻另一方名称";
      
      private var informatText:MyTextField;
      
      private var back:DisplayObject;
      
      private var bangZhiWuArr:Array = [LangConfig.getWord("10371",1),LangConfig.getWord("10372",1),LangConfig.getWord("10373",1),LangConfig.getWord("10374",1)];
      
      public function CityDiaoXiang()
      {
         var diZuo:Bitmap = null;
         diZuo = new Bitmap();
         diZuo.x = -60;
         diZuo.y = -60;
         addChild(diZuo);
         Utils.getLoadBitmap("resource/image/pata/56900.png",diZuo);
         super();
      }
      
      public function init(id:int, diaoXiangType:int, heroId:Number, heroName:String, level:int, sex:int, job:int, shiZhuang:int, wuQi:int, chaoXiang:int, bangHuiMC:String, bangHuiZW:int, equipArr:Array, x:int, y:int, stoneLvl:int, ringId:int, qinmiDu:int, cplName:String) : void
      {
         var str1:String = null;
         var str2:String = null;
         var str3:String = null;
         var str4:String = null;
         this.id = id;
         this.type = UnitType.CITY_DIAOXIANG;
         this.diaoXiangType = diaoXiangType;
         this.heroId = heroId;
         if(Boolean(heroName))
         {
            heroName = Model_heFu.repNameByHero(heroName);
         }
         this.heroName = heroName;
         this.sex = sex;
         this.job = job;
         this.level = level;
         this.shiZhuang = shiZhuang;
         this.wuQi = wuQi;
         this.bangHuiMC = bangHuiMC;
         this.bangHuiZW = bangHuiZW;
         this.chaoXiang = 4;
         this.equipArr = equipArr;
         this.stoneLvl = stoneLvl;
         this.ringId = ringId;
         this.qinmiDu = qinmiDu;
         this.couple_other_name = cplName;
         global_x = x;
         global_y = y;
         this.setShadow(Status.NOMAL,11);
         this.back = ComponentUtil.getDisplayObject("DiaoXiang",this,{
            "x":-75,
            "y":-180
         });
         this.informatText = ComponentUtil.getTextField("",this);
         this.informatText.wordWrap = true;
         this.informatText.width = 125;
         this.informatText.height = 45;
         this.informatText.align = TextFormatAlign.CENTER;
         this.informatText.x = this.back.x + 5;
         if(Boolean(heroId))
         {
            this.setBody(Status.NOMAL,int(shiZhuang));
            str1 = bangHuiMC == "" ? "" : "<font color=\'#04ff00\'>" + bangHuiMC + "</font>";
            str2 = bangHuiZW < 1 ? "" : "<font color=\'#04ff00\'> ▪ " + this.bangZhiWuArr[bangHuiZW - 1] + "</font>";
            str3 = bangHuiMC != "" || Boolean(bangHuiZW) ? "\n" : "";
            str4 = "<font color=\'#f9ff00\'>" + heroName + "</font>";
            this.informatText.htmlText = str1 + str2 + str3 + str4;
            this.informatText.y = this.back.y + (this.back.height - this.informatText.textHeight) / 2;
         }
         else
         {
            this.informatText.visible = false;
         }
         way = int(4);
         status = Status.NOMAL;
      }
      
      public function refresh(str:String) : void
      {
      }
      
      override public function interaction(mode:int = 0) : void
      {
         var voR:vo_otherRoleInfo = null;
         if(this.heroId == 0)
         {
            return;
         }
         if(Boolean(this.equipArr))
         {
            voR = new vo_otherRoleInfo();
            voR.roleId = this.heroId;
            voR.roleName = this.heroName;
            voR.roleSex = sex;
            voR.roleLevel = level;
            voR.roleJob = job;
            voR.equipArr = this.equipArr;
            voR.ringId = this.ringId;
            voR.qinmiDu = this.qinmiDu;
            voR.stoneLvl = this.stoneLvl;
            voR.couple_other_name = this.couple_other_name;
            WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
            {
               pan.showTitle(diaoXiangType);
               pan.update(voR);
            });
         }
         RoleCGMessage.GC_DIAOXIANG_CLICK(this.heroId);
         RoleCGMessage.CG_CHECK_OTHER_NEW(this.heroId);
      }
      
      override public function show() : void
      {
         super.show();
         nameBar.show();
         list[id] = this;
      }
      
      override public function set bodyLoaded(value:Boolean) : void
      {
         super.bodyLoaded = value;
         if(!this.heroId)
         {
            partTem.visible = false;
            parts.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         delete list[id];
         this.removeChild(this.back);
         this.removeChild(this.informatText);
         this.back = null;
         this.informatText = null;
         pool.push(this);
         action = Action.STAND;
      }
   }
}


package com.yiTian.view.modules.pata
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PataCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class PaTaDiaoXiang extends Role
   {
      
      public static var pool:Array = [];
      
      public static var list:Dictionary = new Dictionary();
      
      private var bangZhiWuArr:Array;
      
      public var heroId:Number = 0;
      
      public var heroName:String;
      
      public var shiZhuang:int;
      
      public var wuQi:int;
      
      public var bangHuiMC:String;
      
      public var bangHuiZW:String;
      
      public var chaoXiang:int;
      
      public var isCap:int;
      
      public var heroPostion:String;
      
      public var petPostion:int;
      
      public var xc:int;
      
      public var yc:int;
      
      private var informatText:MyTextField;
      
      private var back:DisplayObject;
      
      private var diZuoBG:Bitmap;
      
      private const diZuoXY:Array = [[-85,-25],[-60,-30],[-50,-265],[-55,-25],[-73,-25]];
      
      public function PaTaDiaoXiang()
      {
         super();
      }
      
      public function init(id:Number, heroId:String, heroName:String, sex:String, job:String, level:String, shiZhuang:String, wuQi:String, bangHuiMC:String, bangHuiZW:String, chaoXiang:String, heroPostion:String, petPostion:String, x:String, y:String, diZuo:int, layers:int) : void
      {
         var str1:String = null;
         var str2:String = null;
         var str3:String = null;
         var str4:String = null;
         this.bangZhiWuArr = [LangConfig.getWord("10371",1),LangConfig.getWord("10372",1),LangConfig.getWord("10373",1),LangConfig.getWord("10374",1)];
         this.id = int(id);
         this.type = UnitType.FUBEN_DIAOXIANG;
         this.heroId = Number(heroId);
         this.heroName = heroName;
         if(Boolean(heroName))
         {
            heroName = Model_heFu.repNameByHero(heroName);
         }
         this.sex = int(sex);
         this.job = int(job);
         this.level = int(level);
         this.shiZhuang = int(shiZhuang);
         this.wuQi = int(wuQi);
         this.bangHuiMC = bangHuiMC;
         this.bangHuiZW = bangHuiZW;
         this.chaoXiang = int(4);
         this.isCap = int(this.isCap);
         this.heroPostion = heroPostion;
         this.petPostion = int(petPostion);
         global_x = int(x);
         global_y = int(y);
         this.setShadow(Status.NOMAL,11);
         if(id < 3)
         {
            this.diZuoBG = new Bitmap();
            addChild(this.diZuoBG);
            Utils.getLoadBitmap("resource/image/pata/" + diZuo + ".png",this.diZuoBG);
            this.setChildIndex(this.diZuoBG,0);
            this.diZuoBG.x = this.diZuoXY[layers / 12 - 1][0];
            this.diZuoBG.y = this.diZuoXY[layers / 12 - 1][1];
            this.back = ComponentUtil.getDisplayObject("DiaoXiang",this,{
               "x":-65,
               "y":-190
            });
            this.informatText = ComponentUtil.getTextField("",this);
            this.informatText.wordWrap = true;
            this.informatText.width = 130;
            this.informatText.height = 45;
            this.informatText.align = TextFormatAlign.CENTER;
            this.informatText.x = this.back.x + 5;
            if(Boolean(heroId))
            {
               this.setBody(Status.NOMAL,int(shiZhuang));
               str1 = bangHuiMC == "0" ? "" : "<font color=\'#04ff00\'>" + bangHuiMC + "</font>";
               str2 = int(bangHuiZW) < 1 ? "" : "<font color=\'#04ff00\'> ▪ " + this.bangZhiWuArr[int(bangHuiZW) - 1] + "</font>";
               str3 = bangHuiMC != "0" || bangHuiZW != "0" ? "\n" : "";
               str4 = "<font color=\'#f9ff00\'>" + heroName + "</font>";
               this.informatText.htmlText = str1 + str2 + str3 + str4;
               this.informatText.y = this.back.y + (this.back.height - this.informatText.textHeight) / 2;
            }
            else
            {
               parts.visible = false;
               partTem.visible = false;
               this.informatText.visible = false;
            }
         }
         else
         {
            this.setBody(Status.NOMAL,diZuo);
         }
         way = int(4);
         status = Status.NOMAL;
      }
      
      override public function interaction(mode:int = 0) : void
      {
         if(id == 3)
         {
            View_Alert.show(LangConfig.getWord("10376",1),View_Alert.OK_CANCAL,this.okCallBack);
         }
         else if(Boolean(this.heroId))
         {
            PataCGMessage.CG_OVERLORD_INFO(this.heroId);
            RoleCGMessage.GC_DIAOXIANG_CLICK(this.heroId);
            WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
            {
               pan.showTitle(-1);
            });
            RoleCGMessage.CG_CHECK_OTHERROLE(this.heroId);
            RoleCGMessage.CG_CHECK_OTHER_NEW(this.heroId);
         }
         if(Boolean(GameUnitManager.hero.lockTarget))
         {
            GameUnitManager.hero.lockTarget = null;
         }
      }
      
      private function okCallBack() : void
      {
         if(Model_team.teamMumberInfo_data_save.length > 1)
         {
            if(Model_team.isCap())
            {
               if(Model_team.isAway())
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10377",1) + "</font>");
               }
               else
               {
                  PataCGMessage.CG_CHALLENGE_OVERLORD_STATE();
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10378",1) + "</font>");
            }
         }
         else
         {
            PataCGMessage.CG_CHALLENGE_OVERLORD_STATE();
         }
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
         if(id != 3)
         {
            if(!this.heroId)
            {
               partTem.visible = false;
               parts.visible = false;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         delete list[id];
         if(Boolean(this.back))
         {
            this.removeChild(this.back);
            this.back = null;
         }
         if(Boolean(this.informatText))
         {
            this.removeChild(this.informatText);
            this.informatText = null;
         }
         if(Boolean(this.diZuoBG))
         {
            this.removeChild(this.diZuoBG);
            this.diZuoBG = null;
         }
         if(!parts.visible)
         {
            parts.visible = true;
         }
         pool.push(this);
         action = Action.STAND;
      }
   }
}


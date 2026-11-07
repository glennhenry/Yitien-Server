package com.yiTian.gameUnit.role
{
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.baby.babyManager.Enum_baby;
   import com.yiTian.view.modules.pet.PetPanel;
   import flash.utils.Dictionary;
   
   public class Pet extends Role
   {
      
      public static var pool:Array = [];
      
      public static var list:Dictionary = new Dictionary();
      
      public static var heroIdList:Dictionary = new Dictionary();
      
      private static const PETNAMES:Array = ["熊猫","布鲁","麒麟","企鹅"];
      
      public var heroId:Number;
      
      private var _zhizi:int;
      
      private var _czlevel:int;
      
      public var body:int;
      
      public var pet_type:int;
      
      private var _cztxEff:Effect;
      
      private var _cztxExtralEff:Effect;
      
      private var effIdArr:Array = ["35220","35221","35222","35223","35224","35225","35226"];
      
      private var effIdExtralArr:Array = ["0","35221","35222","35223","35224","35225","35226"];
      
      public var tupo:int;
      
      public function Pet()
      {
         super();
      }
      
      public static function getPosition(heroId:Number) : Array
      {
         var player:Player = null;
         for each(player in Player.list)
         {
            if(Boolean(player) && player.id == heroId)
            {
               return [player.global_x,player.global_y];
            }
         }
         return null;
      }
      
      public function init(heroId:Number, petId:Number, petName:String, body1:int, body2:int, body3:int, speed:int, hp:int, hpMax:int, level:int, zhizi:int, chengzhang:int, hxjx:int, petType:int, tupo:int) : void
      {
         var body:int = 0;
         type = UnitType.PET;
         this.id = petId;
         this.heroId = heroId;
         this.speed = speed;
         if(Boolean(Player.list[heroId]))
         {
            this.speed = Player.list[heroId].speed;
         }
         this.hp = hp;
         this.hpMax = hpMax;
         this.level = level;
         this.tupo = tupo;
         this._zhizi = zhizi;
         this.pet_type = petType;
         if(Global.pf == "qqgame")
         {
            body = body2;
            if(body == 20907)
            {
               if(PETNAMES.indexOf(petName) != -1)
               {
                  petName = "布鲁";
               }
            }
         }
         else if(Global.pf == "3366")
         {
            body = body2;
            if(body == 20907)
            {
               if(PETNAMES.indexOf(petName) != -1)
               {
                  petName = "布鲁";
               }
            }
            Utils.print("3366");
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            body = body3;
            if(body == 20908)
            {
               if(PETNAMES.indexOf(petName) != -1)
               {
                  petName = "企鹅";
               }
            }
         }
         else
         {
            body = body1;
            if(body == 20906)
            {
               if(PETNAMES.indexOf(petName) != -1)
               {
                  petName = "麒麟";
               }
            }
         }
         if(body == 20901)
         {
            if(PETNAMES.indexOf(petName) != -1)
            {
               petName = "熊猫";
            }
         }
         if(Boolean(hxjx))
         {
            body = PetPanel.transtPetModelID(body);
            nameBar.y = -120;
         }
         else
         {
            nameBar.y = -100;
         }
         if(body == 20526 || body == 20527)
         {
            nameBar.y = -80;
         }
         this.body = body;
         this.cztx = chengzhang;
         this.name = petName;
         this.setShadow(Status.NOMAL,11);
         this.setBody(Status.NOMAL,body);
         way = 0;
         status = Status.NOMAL;
         if(hp > 0)
         {
            state = State.LIFE;
         }
         else
         {
            state = State.DEAD;
         }
      }
      
      public function get zhizi() : String
      {
         if(this.pet_type < 1)
         {
            if(this._zhizi <= 50)
            {
               return ColorConstant.getColorStr(ColorConstant.WHITE);
            }
            if(this._zhizi <= 70)
            {
               return ColorConstant.getColorStr(ColorConstant.GREEN);
            }
            if(this._zhizi <= 90)
            {
               return ColorConstant.getColorStr(ColorConstant.BLUE);
            }
            return ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         if(this.pet_type == 1)
         {
            return ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         if(this.pet_type == 2)
         {
            return ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         if(this.pet_type >= 3)
         {
            return ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         return "#ffffff";
      }
      
      public function set cztx(value:int) : void
      {
         this._czlevel = value;
         if(this._czlevel > 1 && Enum_baby.zinvId.indexOf(this.body) == -1)
         {
            if(Boolean(this._cztxEff))
            {
               removeEffect(this._cztxEff);
            }
            if(Boolean(this._cztxExtralEff))
            {
               removeEffect(this._cztxExtralEff);
               this._cztxExtralEff = null;
            }
            if(this._czlevel < 5)
            {
               this._cztxEff = addEffect("35056",true,0,0,700,-1,null,1);
            }
            else if(this._czlevel < 7)
            {
               this._cztxEff = addEffect("35057",true,0,0,700,-1,null,1);
            }
            else if(this._czlevel < 10)
            {
               this._cztxEff = addEffect("35058",true,0,0,700,-1,null,1);
            }
            else if(this._czlevel < 15)
            {
               this._cztxEff = addEffect("35059",true,0,0,700,-1,null,1);
            }
            else if(this._czlevel < 20)
            {
               this._cztxEff = addEffect("35089",true,0,0,700,-1,null,1);
            }
            else if(this._czlevel == 20 && this.tupo == 0)
            {
               this._cztxEff = addEffect("35090",true,0,0,700,-1,null,1);
            }
            else
            {
               this._cztxEff = addEffect("35220",true,0,0,700,-1,null,1);
               if(this._czlevel >= 22)
               {
                  if(this.tupo > 1)
                  {
                     this._cztxExtralEff = addEffect(this.effIdExtralArr[this.tupo - 1],true,0,0,700,-1,null,0);
                  }
               }
            }
         }
         else
         {
            if(Boolean(this._cztxEff))
            {
               removeEffect(this._cztxEff);
               this._cztxEff = null;
            }
            if(Boolean(this._cztxExtralEff))
            {
               removeEffect(this._cztxExtralEff);
               this._cztxExtralEff = null;
            }
         }
      }
      
      override public function isHidePlayer() : Boolean
      {
         return this.heroId != GameUnitManager.hero.id;
      }
      
      override public function show() : void
      {
         var position:Array = getPosition(this.heroId);
         if(Boolean(position))
         {
            global_x = position[0] + 40;
            global_y = position[1] + 30;
         }
         super.show();
         nameBar.show();
         list[id] = this;
         heroIdList[this.heroId] = this;
      }
      
      override public function interaction(mode:int = 0) : void
      {
         super.interaction(mode);
      }
      
      override public function dispose() : void
      {
         if(this.heroId != GameUnitManager.hero.id)
         {
            this.cztx = 0;
            super.dispose();
            pool.push(this);
            status = Status.NOMAL;
         }
         delete list[id];
         delete heroIdList[this.heroId];
         action = Action.STAND;
         state = State.LIFE;
         visible = true;
      }
   }
}


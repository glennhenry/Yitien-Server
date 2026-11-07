package com.yiTian.view.modules.paoku.userCom.role
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.modules.paoku.core.entity.MoveData;
   import com.yiTian.view.modules.paoku.core.entity.eComponent.IEntityCtrl;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.eComp.BitmapViewCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.BulletBehvCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.CoinBehvCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.EffectViewCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.HeroMoveCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.HeroViewCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.MovieClipViewCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.PlayerStateCtrl;
   import com.yiTian.view.modules.paoku.userCom.eComp.UserKeyCtrl;
   import com.yiTian.view.modules.paoku.userCom.map.KuPaoBlock;
   import com.yiTian.view.modules.paoku.userCom.util.Config;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class EntityFactory
   {
      
      private static var _hero:KuPaoEntity;
      
      private static var pool:Dictionary = new Dictionary();
      
      public function EntityFactory()
      {
         super();
      }
      
      public static function buildInstance(info:XML, block:KuPaoBlock) : KuPaoEntity
      {
         var rest:KuPaoEntity = null;
         var behvCtrl:IEntityCtrl = null;
         var effectViewCtrl:EffectViewCtrl = null;
         var width:Number = NaN;
         var height:Number = NaN;
         var scaleXX:Number = NaN;
         var scaleYY:Number = NaN;
         var mc:MovieClip = null;
         var movViewCtrl:MovieClipViewCtrl = null;
         var bmc:BulletBehvCtrl = null;
         var type:int = int(info.@type);
         if(type == 1)
         {
            rest = getEntity(1);
            if(rest == null)
            {
               rest = new KuPaoEntity();
               effectViewCtrl = new EffectViewCtrl();
               effectViewCtrl.effectID = "36132";
               effectViewCtrl.time = 1000;
               rest.addCtrl(effectViewCtrl);
               rest.getQuad().width = 24;
               rest.getQuad().height = 24;
               behvCtrl = new CoinBehvCtrl();
               rest.addCtrl(behvCtrl);
               rest.moveData = new MoveData();
            }
            rest.acceptMsg(KuPaoEntityMsgConst.HERO_HIT);
            rest.acceptMsg(KuPaoEntityMsgConst.AUTO_TOHERO);
            rest.moveData.xPos = int(info.@x) + block.col * Config.BLOCK_WID;
            rest.moveData.yPos = KuPaoUtil.convertViewY(int(info.@y));
         }
         else if(type == 100)
         {
            rest = getEntity(100);
            if(rest == null)
            {
               rest = new KuPaoEntity();
               mc = ComponentUtil.getDisplayObject("bullet1",null,null,Global.MMKPdm) as MovieClip;
               mc.mouseEnabled = false;
               movViewCtrl = new MovieClipViewCtrl();
               movViewCtrl._movie = mc;
               rest.addCtrl(movViewCtrl);
               movViewCtrl.setName("mcCtrl");
               bmc = new BulletBehvCtrl();
               rest.addCtrl(bmc);
               rest.acceptMsg(KuPaoEntityMsgConst.HERO_HIT);
               rest.moveData = new MoveData();
            }
            else
            {
               mc = (rest.getCtrl("mcCtrl") as MovieClipViewCtrl)._movie;
            }
            width = Number(info.@width);
            height = Number(info.@height);
            scaleXX = 1;
            scaleYY = 1;
            if(width != 0 && height != 0)
            {
               scaleXX = width / 50;
               scaleYY = height / 50;
            }
            else
            {
               scaleXX = 0.6;
               scaleYY = 0.6;
            }
            rest.getQuad().width = 50 * scaleXX;
            rest.getQuad().height = 50 * scaleYY;
            mc.scaleX = scaleXX;
            mc.scaleY = scaleYY;
            rest.moveData.xPos = int(info.@x) - 50 * scaleXX + block.col * Config.BLOCK_WID;
            rest.moveData.yPos = KuPaoUtil.convertViewY(int(info.@y)) - 50 * scaleYY;
         }
         return rest;
      }
      
      public static function getEntity(type:int) : KuPaoEntity
      {
         if(Boolean(pool[type]) && pool[type].length > 0)
         {
            return pool[type].pop();
         }
         return null;
      }
      
      public static function saveEntity(entity:KuPaoEntity, type:int) : void
      {
         pool[type] = pool[type] || [];
         pool[type].push(entity);
      }
      
      public static function getHero() : KuPaoEntity
      {
         var hero:KuPaoEntity = null;
         var keyCtrl:UserKeyCtrl = null;
         var heroStateCtrl:PlayerStateCtrl = null;
         var moveCtrl:HeroMoveCtrl = null;
         var viewCtrl:HeroViewCtrl = null;
         if(_hero == null)
         {
            hero = new KuPaoEntity();
         }
         else
         {
            hero = _hero;
         }
         if(_hero == null)
         {
            hero.moveData = new MoveData();
            hero.quadRect.width = 26;
            hero.quadRect.height = 72;
            hero.userDataMap.jump = 12;
            keyCtrl = new UserKeyCtrl();
            hero.addCtrl(keyCtrl);
            heroStateCtrl = new PlayerStateCtrl();
            heroStateCtrl.configureHeroStates();
            hero.addCtrl(heroStateCtrl);
            moveCtrl = new HeroMoveCtrl();
            hero.addCtrl(moveCtrl);
            viewCtrl = new HeroViewCtrl();
            hero.addCtrl(viewCtrl);
         }
         _hero = hero;
         _hero.acceptMsg(KuPaoEntityMsgConst.CHANGE_ACTIONVIEW);
         _hero.acceptMsg(KuPaoEntityMsgConst.CHANGE_STATE);
         _hero.acceptMsg(KuPaoEntityMsgConst.HURT);
         _hero.acceptMsg(KuPaoEntityMsgConst.ADD_EFFECT);
         _hero.acceptMsg(KuPaoEntityMsgConst.REMOVE_EFFECT);
         return _hero;
      }
   }
}


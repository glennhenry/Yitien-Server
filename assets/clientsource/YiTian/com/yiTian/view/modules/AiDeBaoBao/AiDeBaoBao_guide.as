package com.yiTian.view.modules.AiDeBaoBao
{
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_AiDeBaoBao;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.scene.GameScene;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class AiDeBaoBao_guide
   {
      
      private static var _instance:AiDeBaoBao_guide;
      
      private static var needRunSkill_1:Boolean;
      
      private static var needRunSkill_2:Boolean;
      
      private static var needRunSkill_3:Boolean;
      
      private var arrowPointToFindPartner:ArrowEffect;
      
      private var enemy:Player;
      
      private var enemyArrow:ArrowEffect;
      
      public function AiDeBaoBao_guide()
      {
         super();
         this.Init();
      }
      
      public static function get instance() : AiDeBaoBao_guide
      {
         if(!_instance)
         {
            _instance = new AiDeBaoBao_guide();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         needRunSkill_1 = true;
         needRunSkill_2 = true;
         needRunSkill_3 = true;
         Global.control.registerCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_CHECK_SKILL,this.onPointToCheckSkill);
         Global.control.registerCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_FIND_PARTNER,this.onPointToFindPartner);
         Global.control.registerCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_GET_PARTNER,this.onPointToGetPartner);
         Global.control.registerCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_SKILL,this.onPointToSkill);
         Global.control.registerCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_HIDE,this.onHideFindPartnerPoint);
      }
      
      private function onPointToFindPartner(e:*) : void
      {
         Global.control.removeCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_FIND_PARTNER,this.onPointToFindPartner);
         this.arrowPointToFindPartner = new ArrowEffect();
         this.arrowPointToFindPartner.rotation = -90;
         this.arrowPointToFindPartner.x = View_AiDeBaoBao_findPartner.instance.width / 2 + 29;
         this.arrowPointToFindPartner.y = View_AiDeBaoBao_findPartner.instance.height + 34;
         View_AiDeBaoBao_findPartner.instance.addChild(this.arrowPointToFindPartner);
         View_AiDeBaoBao_findPartner.instance.lightBtn();
      }
      
      private function onPointToGetPartner(e:*) : void
      {
         var arrow:ArrowEffect = null;
         Global.control.removeCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_GET_PARTNER,this.onPointToGetPartner);
         arrow = new ArrowEffect();
         arrow.x = 375;
         arrow.y = 90;
         View_AiDeBaoBao_partnerMenu.instance.addChild(arrow);
         Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_Kuang_SHOW,null);
      }
      
      private function onPointToCheckSkill(e:*) : void
      {
         var arrow:ArrowEffect = null;
         Global.control.removeCallBack(Enum_AiDeBaoBao.GUIDE_ARROW_POINT_TO_CHECK_SKILL,this.onPointToCheckSkill);
         arrow = new ArrowEffect();
         arrow.rotation = 90;
         arrow.x = 83 + 75;
         arrow.y = -10;
         View_AiDeBaoBao_skillBar.instance.addChild(arrow);
         View_AiDeBaoBao_skillBar.instance.onPointToCheckSkill();
      }
      
      private function onPointToSkill(e:int) : void
      {
         var arrow:ArrowEffect = null;
         var skillEff:SkillEffect = null;
         var dis:int = 0;
         var dis_min:int = 0;
         var point_self:Point = null;
         var i:* = undefined;
         switch(e)
         {
            case 1:
               if(!needRunSkill_1)
               {
                  return;
               }
               needRunSkill_1 = false;
               if(needRunSkill_2 == false && needRunSkill_3 == false)
               {
                  AiDeBaoBaoCGMessage.CG_AiDeBaoBao_GUIDE();
               }
               UIManager.centerBroadcast.addMsg("你可以使用<font color=\'#ff0000\'>加速</font>技能哦~");
               Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_SKILL_TIPS,1);
               break;
            case 2:
               if(!needRunSkill_2)
               {
                  return;
               }
               needRunSkill_2 = false;
               if(needRunSkill_1 == false && needRunSkill_3 == false)
               {
                  AiDeBaoBaoCGMessage.CG_AiDeBaoBao_GUIDE();
               }
               Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_SKILL_TIPS,2);
               break;
            case 3:
               if(!needRunSkill_3)
               {
                  return;
               }
               dis = 0;
               dis_min = -1;
               point_self = new Point(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
               for(i in Player.list)
               {
                  if(!(Player.list[i].status == Status.AiDeBaoBao_BeiBao || Player.list[i].id == View_AiDeBaoBao_findPartner.instance.partner || Player.list[i].id == GameUnitManager.hero.id))
                  {
                     dis = int(Point.distance(point_self,new Point(Player.list[i].global_x,Player.list[i].global_y)));
                     if(dis_min == -1)
                     {
                        dis_min = dis;
                        this.enemy = Player.list[i];
                     }
                     else if(dis < dis_min)
                     {
                        this.enemy = Player.list[i];
                     }
                  }
               }
               if(!this.enemy)
               {
                  return;
               }
               this.skill_3_handle();
               return;
         }
         arrow = new ArrowEffect();
         arrow.rotation = 90;
         arrow.x = 83 + (e - 1) * 50;
         arrow.y = -10;
         View_AiDeBaoBao_skillBar.instance.addChild(arrow);
         skillEff = new SkillEffect();
         skillEff.x = View_AiDeBaoBao_skillBar.instance.BtnArray[e - 1].x + 17;
         skillEff.y = View_AiDeBaoBao_skillBar.instance.BtnArray[e - 1].y + 17;
         View_AiDeBaoBao_skillBar.instance.addChild(skillEff);
      }
      
      private function skill_3_handle() : void
      {
         var playerX:int = this.enemy.global_x - CameraManager.sightX;
         var playerY:int = this.enemy.global_y - CameraManager.sightY;
         if(playerX < Global.stage.stageWidth / 4 || playerX > Global.stage.stageWidth / 4 * 3 || playerY < Global.stage.stageHeight / 4 || playerY > Global.stage.stageHeight / 4 * 3)
         {
            return;
         }
         needRunSkill_3 = false;
         if(needRunSkill_1 == false && needRunSkill_2 == false)
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_GUIDE();
         }
         this.enemyArrow = new ArrowEffect();
         this.enemyArrow.rotation = 90;
         GameScene.mainLayer.addChild(this.enemyArrow);
         GameScene.instance.addFrameCallBack(this.onFollowEnemy);
         setTimeout(this.pointToSkill_34,3000);
      }
      
      private function onFollowEnemy() : void
      {
         if(GameUnitManager.hero.status == Status.AiDeBaoBao_BeiBao)
         {
            this.enemyArrow.x = this.enemy.global_x;
            this.enemyArrow.y = this.enemy.global_y - 150;
         }
      }
      
      private function pointToSkill_34() : void
      {
         var arrow1:ArrowEffect = null;
         var skillEff1:SkillEffect = null;
         var arrow2:ArrowEffect = null;
         var skillEff2:SkillEffect = null;
         GameScene.instance.removeFrameCallBack(this.onFollowEnemy);
         if(GameUnitManager.hero.status != Status.AiDeBaoBao_BeiBao)
         {
            return;
         }
         Global.control.sendNotification(Enum_AiDeBaoBao.GUIDE_SKILL_TIPS,3);
         arrow1 = new ArrowEffect();
         arrow1.rotation = 90;
         arrow1.x = 183;
         arrow1.y = -10;
         View_AiDeBaoBao_skillBar.instance.addChild(arrow1);
         skillEff1 = new SkillEffect();
         skillEff1.x = View_AiDeBaoBao_skillBar.instance.BtnArray[2].x + 17;
         skillEff1.y = View_AiDeBaoBao_skillBar.instance.BtnArray[2].y + 17;
         View_AiDeBaoBao_skillBar.instance.addChild(skillEff1);
         arrow2 = new ArrowEffect();
         arrow2.rotation = 90;
         arrow2.x = 233;
         arrow2.y = -10;
         View_AiDeBaoBao_skillBar.instance.addChild(arrow2);
         skillEff2 = new SkillEffect();
         skillEff2.x = View_AiDeBaoBao_skillBar.instance.BtnArray[3].x + 17;
         skillEff2.y = View_AiDeBaoBao_skillBar.instance.BtnArray[3].y + 17;
         View_AiDeBaoBao_skillBar.instance.addChild(skillEff2);
      }
      
      private function onHideFindPartnerPoint(e:*) : void
      {
         if(Boolean(this.arrowPointToFindPartner.stage))
         {
            this.arrowPointToFindPartner.hide();
         }
      }
   }
}

import com.yiTian.data.config.Enum_AiDeBaoBao;
import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.manager.EffectManager;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.setTimeout;

class SkillEffect extends Sprite
{
   
   private var eff:Effect;
   
   public function SkillEffect()
   {
      super();
      this.eff = EffectManager.addEffect("35253",this,2000,0,0,true);
      this.mouseChildren = false;
      this.mouseEnabled = false;
      this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
   }
   
   private function onAddToStage(e:Event) : void
   {
      setTimeout(this.hide,Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
   }
   
   private function hide() : void
   {
      EffectManager.removeEffect(this.eff);
   }
}

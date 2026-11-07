package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.broadcast.StrengthTip;
   import com.yiTian.view.modules.guangMingDing.View_guangMingDingTeamPanel;
   import com.yiTian.view.modules.jingJiChang.View_CZItem;
   import com.yiTian.view.modules.kuafujingjichang.TeamPanel;
   import com.yiTian.view.modules.newerGuide.thirdNewerGuide.Child_panPet;
   import com.yiTian.view.modules.pet.NeiDanVO;
   import com.yiTian.view.modules.pet.PetEffect;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import com.yiTian.view.modules.team.ChaKanTeam;
   import com.yiTian.view.modules.team.TeamListPanel;
   import com.yiTian.view.modules.team.TeamSignTogether;
   
   public class PetHandler
   {
      
      public function PetHandler()
      {
         super();
      }
      
      public static function GC_PET(result:int, petVO:*) : void
      {
         if(Boolean(petVO.hxjx))
         {
            petVO.img = PetPanel.transtPetModelID(petVO.img);
         }
         calStrength(petVO,UIManager.petPanel.petVO);
         UIManager.petPanel.petVO = petVO;
         UIManager.petPanel.update();
         UIManager.petHeadPanel.visible = true;
         UIManager.petHeadPanel.update();
      }
      
      public static function GC_PET_JIEDAN(result:int) : void
      {
         if(result == 1)
         {
            UIManager.petTipPanel.visible = true;
         }
         UIManager.petPanel.playEff(PetPanel.NEIDAN);
         if(NeiDanVO.effType == 1)
         {
            PetEffect.getInstance().play(PetEffect.TSCG);
         }
         else if(NeiDanVO.effType == 2)
         {
            PetEffect.getInstance().play(PetEffect.JDCG);
         }
         else if(NeiDanVO.effType == 3)
         {
            PetEffect.getInstance().play(PetEffect.JJCG);
         }
      }
      
      public static function GC_PET_XIZI(result:int) : void
      {
         if(result == 1)
         {
            UIManager.petPanel.update();
         }
         UIManager.petPanel.playEff(PetPanel.XIZI);
         PetEffect.getInstance().play(PetEffect.XZCG);
      }
      
      public static function GC_PET_LIANHUA(result:int) : void
      {
         if(result == 1)
         {
            UIManager.petPanel.update();
         }
         UIManager.petPanel.playEff(PetPanel.LIANHUA);
         PetEffect.getInstance().play(PetEffect.LHCG);
      }
      
      public static function GC_PET_XILIAN(result:int, freeTimes:int, data:Array, times:int, index:int) : void
      {
         UIManager.xiLianJiNengPanel.index = index;
         UIManager.xiLianJiNengPanel.updataBtn(freeTimes);
         UIManager.xiLianJiNengPanel.updataGrid(data);
         UIManager.xiLianJiNengPanel.updataStar(times);
      }
      
      public static function GC_PET_JINGNENG_XILIAN(result:int, data:Array, freeTimes:int, index:int, times:int) : void
      {
         UIManager.xiLianJiNengPanel.index = index;
         UIManager.xiLianJiNengPanel.updataBtn(freeTimes);
         UIManager.xiLianJiNengPanel.updataGrid(data);
         UIManager.xiLianJiNengPanel.updataStar(times);
      }
      
      public static function GC_PET_JINGNENG_CHANGE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10389",1));
            UIManager.xiLianJiNengPanel.visible = false;
         }
         else if(result == -1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10390",1));
         }
      }
      
      public static function GC_PET_OTHER_INFO(result:int, petVO:*) : void
      {
         var tlp:TeamListPanel = null;
         if(PetPanel.curPanel is TeamSignTogether)
         {
            UIManager.teamSignTogether.showPetInfoView(petVO);
         }
         else if(PetPanel.curPanel is TeamListPanel)
         {
            tlp = TeamListPanel.data[Model_team.team_id];
            tlp.showPetInfoView(petVO);
         }
         else if(PetPanel.curPanel is View_CZItem)
         {
            UIManager.cz_info.showPetInfoView(petVO);
         }
         else if(PetPanel.curPanel is ChaKanTeam)
         {
            UIManager.chaKanTeam.showPetInfoView(petVO);
         }
         else if(PetPanel.curPanel is TeamPanel)
         {
            UIManager.team.showPetInfoView(petVO);
         }
         else if(PetPanel.curPanel is View_guangMingDingTeamPanel)
         {
            View_guangMingDingTeamPanel.getInstance().showPetInfoView(petVO);
         }
      }
      
      public static function GC_PET_BIANSHENGKA(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10391",1));
            if(Child_panPet.instance.visible)
            {
               Child_panPet.instance.visible = false;
            }
            UIManager.bianShengKa.visible = false;
         }
      }
      
      public static function GC_PET_YELLOWDIAMOND(result:int) : void
      {
         UIManager.special_btn.showYD(result == 1 ? true : false);
      }
      
      public static function GC_PET_YELLOWDIAMOND_AWARD(result:int) : void
      {
         UIManager.yellowDiamond.setYellowPetBtn(1);
      }
      
      public static function GC_PET_SHOW_FASHION(result:int) : void
      {
         UIManager.petPanel.updateSelect(result);
      }
      
      public static function GC_OPEN_JINGXIU() : void
      {
      }
      
      public static function GC_BT_JINGXIU() : void
      {
      }
      
      public static function calStrength(curVo:PetVO, hisVo:PetVO) : void
      {
         var sub:Number = NaN;
         if(Boolean(hisVo && curVo) && Boolean(curVo.zhanLi != 0) && hisVo.zhanLi != 0)
         {
            sub = curVo.zhanLi - hisVo.zhanLi;
            if(sub > 0)
            {
               StrengthTip.showADD(hisVo.zhanLi,sub,"宠物战力 ");
            }
            else if(sub < 0)
            {
               StrengthTip.showSub(sub,"宠物战力");
            }
         }
      }
      
      public static function GC_ChongWuJinJie(result:int) : void
      {
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("境界提升成功",1);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("道具数量不足，无法提升境界",1);
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("等级不足，无法提升境界",1);
         }
      }
   }
}


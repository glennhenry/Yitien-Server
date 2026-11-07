package com.yiTian.view.modules.team
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TeamMemberMessage extends Sprite
   {
      
      private static var strDes:Array = ["姓名：","职业：","等级："];
      
      private var Button_Pet_text01:Button;
      
      private var Name_text01:MyTextField;
      
      private var Job_text01:MyTextField;
      
      private var Lever_text01:MyTextField;
      
      private var Pet_text01:MyTextField;
      
      private var _job:Array;
      
      private var dateArr:Array;
      
      public function TeamMemberMessage()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._job = [LangConfig.getWord("10036",1),LangConfig.getWord("10037",1),LangConfig.getWord("10038",1),LangConfig.getWord("10039",1)];
         this.Name_text01 = ComponentUtil.getTextField(LangConfig.getWord("60297",6),this,{
            "x":1,
            "y":0,
            "color":16777215
         });
         this.Job_text01 = ComponentUtil.getTextField(LangConfig.getWord("60298",6),this,{
            "x":1,
            "y":17.7,
            "color":16777215
         });
         this.Lever_text01 = ComponentUtil.getTextField(LangConfig.getWord("60299",6),this,{
            "x":1,
            "y":35.4,
            "color":16777215
         });
         this.Button_Pet_text01 = ComponentUtil.getButton(LangConfig.getWord("10047",1),"Button_Two",this,{
            "x":74.15,
            "y":35.65,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Pet_text01.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         if(this.dateArr[13] == GameUnitManager.hero.id)
         {
            if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
            {
               return;
            }
            if(Boolean(UIManager.petPanel.petVO))
            {
               UIManager.petPanel.visible = !UIManager.petPanel.visible;
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
            }
         }
         else
         {
            if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
            {
               return;
            }
            if(this.parent is TeamListPanel)
            {
               if(this.dateArr[11] > 0)
               {
                  (this.parent as TeamListPanel).petInfoVisible(true);
                  PetCGMessage.CG_PET_OTHER_INFO(this.dateArr[11]);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10173",1) + "</font>");
               }
            }
            else if(this.parent is ChaKanTeam)
            {
               if(this.dateArr[10] > 0)
               {
                  (this.parent as ChaKanTeam).petInfoVisible(true);
                  PetCGMessage.CG_PET_OTHER_INFO(this.dateArr[10]);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10173",1) + "</font>");
               }
            }
         }
      }
      
      public function update(data_arr:Array) : void
      {
         this.dateArr = data_arr;
         data_arr[7] = Model_heFu.repNameByHero(data_arr[7]);
         this.Name_text01.htmlText = strDes[0] + HtmlUtil.font(data_arr[7],Model_jingJiChang.get_color[data_arr[8] - 1]);
         this.Job_text01.htmlText = strDes[1] + HtmlUtil.font(this._job[Enum_job.getBaseJob(data_arr[8]) - 1],"#12537400");
         this.Lever_text01.htmlText = strDes[2] + HtmlUtil.font(data_arr[9].toString(),"#14662240");
      }
   }
}


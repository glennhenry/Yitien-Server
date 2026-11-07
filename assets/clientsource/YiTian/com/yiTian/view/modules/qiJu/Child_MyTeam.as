package com.yiTian.view.modules.qiJu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_QiJu;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Child_MyTeam extends Sprite
   {
      
      private var titleTF:MyTextField;
      
      private var list:MyTeamList;
      
      private var creatTeam:CreatTeam;
      
      private var grid:GridItem;
      
      private var getTeamBtn:Button;
      
      private var startGameBtn:Button;
      
      private var canInvite:Boolean = true;
      
      private var time:Number;
      
      public function Child_MyTeam()
      {
         super();
         this.init();
      }
      
      public function upCreatList(arr:Array) : void
      {
         this.creatTeam.setList(arr);
         this.show(false);
      }
      
      private function showTeamBtn(isCaptain:Boolean) : void
      {
         this.getTeamBtn.visible = this.startGameBtn.visible = isCaptain;
      }
      
      public function show(hasTeam:Boolean) : void
      {
         if(hasTeam)
         {
            if(!View_JoinQiJu.instance.visible)
            {
               View_JoinQiJu.instance.visible = true;
            }
            this.creatTeam.visible = false;
            this.list.visible = true;
            this.upDataList();
            this.titleTF.text = Enum_QiJu.qiju_type[Model_QiJu.team_Type] + " " + Enum_QiJu.type_level[Model_QiJu.team_Type] + LangConfig.getWord("80126",8);
         }
         else
         {
            this.creatTeam.visible = true;
            this.list.visible = false;
            this.titleTF.text = LangConfig.getWord("80127",8);
            QiJuHandler.dispose();
         }
         this.showTeamBtn(Model_QiJu.isCaptain);
      }
      
      public function showTeamIcon() : void
      {
         this.list.showTeamIcon();
      }
      
      public function upDataGrid(type:int) : void
      {
         this.grid.show(type);
      }
      
      public function upDataList() : void
      {
         this.list.show();
      }
      
      private function init() : void
      {
         this.titleTF = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":0,
            "realWidth":195,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.titleTF.align = "center";
         this.list = new MyTeamList();
         this.creatTeam = new CreatTeam();
         this.grid = new GridItem();
         addChild(this.list);
         addChild(this.creatTeam);
         addChild(this.grid);
         ComponentUtil.setPropertie(this.list,{
            "x":0,
            "y":25
         });
         ComponentUtil.setPropertie(this.creatTeam,{
            "x":0,
            "y":0
         });
         ComponentUtil.setPropertie(this.grid,{
            "x":0,
            "y":139
         });
         this.getTeamBtn = ComponentUtil.getButton(LangConfig.getWord("80128",8),"Button_Four",this,{
            "x":20,
            "y":322 - 47,
            "textColor":16773818,
            "name":"getTeam"
         },Global.Img_Cdm);
         this.startGameBtn = ComponentUtil.getButton(LangConfig.getWord("80129",8),"Button_Four",this,{
            "x":108,
            "y":322 - 47,
            "textColor":16773818,
            "name":"startGame"
         },Global.Img_Cdm);
         this.getTeamBtn.callBack = this.teamFun;
         this.startGameBtn.callBack = this.teamFun;
      }
      
      private function teamFun(event:MouseEvent) : void
      {
         var name:String = event.target.name;
         switch(name)
         {
            case "getTeam":
               if(this.canInvite)
               {
                  QiJuCGMessage.CG_QIJU_TEAMMATE();
                  this.canInvite = false;
                  this.time = getTimer();
                  Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.upTime);
                  break;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80130",8));
               break;
            case "startGame":
               if(UIManager.mainUiBtnContainer.curFuBenType != 0 || Global.sceneID == 12304)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("80161",8));
                  return;
               }
               if(GameUnitManager.hero.paoBiao != 0)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("80162",8));
                  return;
               }
               if(Model_QiJu.myTeamVo.length == 0)
               {
                  return;
               }
               if(Model_QiJu.myTeamVo.length == 1)
               {
                  View_Alert.show(LangConfig.getWord("80131",8),View_Alert.OK_CANCAL,function():void
                  {
                     QiJuCGMessage.CG_START_QIJU();
                  });
                  return;
               }
               QiJuCGMessage.CG_START_QIJU();
         }
      }
      
      private function upTime() : void
      {
         if(getTimer() - this.time >= 60000)
         {
            this.canInvite = true;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.upTime);
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.ComboBox;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.config.Enum_QiJu;
import com.yiTian.data.model.Model_QiJu;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.QiJuCGMessage;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.qiJu.MyTeamItem;
import com.yiTian.view.modules.qiJu.MyTeamVo;
import com.yiTian.view.modules.qiJu.View_JoinQiJu;
import flash.display.Sprite;
import flash.events.MouseEvent;

class GridItem extends Sprite
{
   
   private var gridVec:Vector.<View_Grid>;
   
   public function GridItem()
   {
      super();
      this.init();
   }
   
   public function show(type:int) : void
   {
      var vo:Vo_item = null;
      var item:View_Grid = null;
      var source:Array = null;
      if(type != -1)
      {
         source = Enum_QiJu.reward[type];
      }
      else
      {
         source = [];
      }
      var i:int = 0;
      while(i < 6)
      {
         item = this.gridVec[i];
         if(Boolean(source[i]))
         {
            vo = new Vo_item();
            vo.id = source[i];
            vo.Init_lib();
            item.vo = vo;
         }
         else
         {
            item.vo = null;
         }
         i++;
      }
   }
   
   public function dispose() : void
   {
      var grid:View_Grid = null;
      for each(grid in this.gridVec)
      {
         grid.vo = null;
      }
   }
   
   private function init() : void
   {
      ComponentUtil.getTextField(LangConfig.getWord("80132",8),this,{
         "x":13 + 58,
         "y":0,
         "color":16764206,
         "size":12,
         "leading":0
      });
      this.creatGrid();
   }
   
   private function creatGrid() : void
   {
      var grid:View_Grid = null;
      var i:int = 0;
      this.gridVec = new Vector.<View_Grid>();
      i = 0;
      while(i < 6)
      {
         grid = new View_Grid();
         grid.type = Enum_type_grid.NO_DRAG;
         grid.isAutoLoad = true;
         grid.set_bmp_bg();
         grid.set_bmp_over();
         addChild(grid);
         grid.x = 21 + i % 3 * 60;
         grid.y = 32 + int(i / 3) * 48;
         this.gridVec.push(grid);
         i++;
      }
   }
}

class MyTeamList extends Sprite
{
   
   private var contentTF:MyTextField;
   
   private var listVec:Vector.<MyTeamItem>;
   
   public function MyTeamList()
   {
      super();
      this.init();
   }
   
   public function showTeamIcon() : void
   {
      var item:MyTeamItem = null;
      if(Model_QiJu.team_id == 0)
      {
         return;
      }
      for each(item in this.listVec)
      {
         item.showTeamIcon();
      }
   }
   
   public function show() : void
   {
      var item:MyTeamItem = null;
      var vo:MyTeamVo = null;
      var voVec:Vector.<MyTeamVo> = Model_QiJu.myTeamVo;
      var len:int = int(voVec.length);
      var i:int = 0;
      while(i < 3)
      {
         item = this.listVec[i];
         if(i < len)
         {
            vo = voVec[i];
            item.show(vo);
         }
         else
         {
            item.dispose();
         }
         i++;
      }
      this.contentTF.text = LangConfig.getWord("80133",8) + len + "/3";
   }
   
   private function init() : void
   {
      this.contentTF = ComponentUtil.getTextField("",this,{
         "x":24,
         "y":3,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.creatList();
      this.visible = false;
   }
   
   private function creatList() : void
   {
      var item:MyTeamItem = null;
      var py:int = 0;
      var rangY:int = 0;
      var i:int = 0;
      this.listVec = new Vector.<MyTeamItem>();
      py = 21;
      rangY = 30;
      i = 0;
      while(i < 3)
      {
         item = new MyTeamItem();
         addChild(item);
         item.x = 0;
         item.y = py + i * rangY;
         this.listVec.push(item);
         i++;
      }
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(value)
      {
         View_JoinQiJu.instance.upDataGrid(Model_QiJu.team_Type);
      }
   }
}

class CreatTeam extends Sprite
{
   
   private var select_list:ComboBox;
   
   private var type:int;
   
   public function CreatTeam()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      ComponentUtil.getTextField(LangConfig.getWord("80134",8),this,{
         "x":13,
         "y":43,
         "color":16764206,
         "size":12,
         "leading":0
      });
      ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{
         "x":54 + 13,
         "y":43,
         "width":102,
         "height":24
      },Global.Img_Cdm);
      var btn:Button = ComponentUtil.getButton(LangConfig.getWord("80135",8),"Button_Orange",this,{
         "x":51 + 13,
         "y":35 + 43,
         "textColor":16184781
      },Global.Img_Cdm);
      btn.callBack = this.creatFun;
      this.getList();
      Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.getList);
   }
   
   private function getList() : void
   {
      var index:int = 0;
      var type:Array = null;
      var source:Array = null;
      var len:int = 0;
      var i:int = 0;
      if(GameUnitManager.hero.level >= 80)
      {
         index = (GameUnitManager.hero.level - 80) / 5;
         type = Enum_QiJu.qiju_type.slice(0,index + 1);
         source = [];
         len = int(type.length);
         i = 0;
         while(i < len)
         {
            source[i] = [type[i] + " " + Enum_QiJu.type_level[i] + LangConfig.getWord("80126",8),i];
            i++;
         }
         if(!this.select_list)
         {
            this.select_list = new ComboBox(source,this.select,100,"Button_PageDown","ComboBox_background","xuanze_over",100);
            addChild(this.select_list);
            ComponentUtil.setPropertie(this.select_list,{
               "x":54 + 13,
               "y":43
            });
         }
         else
         {
            this.select_list.source = source;
         }
         this.select_list.select(source[0][1]);
      }
   }
   
   public function setList(arr:Array) : void
   {
      var id:int = 0;
      var source:Array = [];
      if(!arr.length)
      {
         source.push([LangConfig.getWord("80136",8),-1]);
      }
      else
      {
         for each(id in arr)
         {
            source.push([Enum_QiJu.qiju_type[id - 1] + " " + Enum_QiJu.type_level[id - 1] + LangConfig.getWord("80126",8),id - 1]);
         }
      }
      if(!this.select_list)
      {
         this.select_list = new ComboBox(source,this.select,100,"Button_PageDown","ComboBox_background","xuanze_over",100);
         addChild(this.select_list);
         ComponentUtil.setPropertie(this.select_list,{
            "x":54 + 13,
            "y":43
         });
      }
      else
      {
         this.select_list.source = source;
      }
      this.select_list.select(source[0][1]);
      this.select(source[0][1]);
   }
   
   private function select(value:Object) : void
   {
      this.type = int(value);
      View_JoinQiJu.instance.upDataGrid(int(value));
   }
   
   private function creatFun(event:MouseEvent) : void
   {
      if(Model_QiJu.qiJuGame_count - Model_QiJu.qiJuGame_time <= 0)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("80167",8));
         return;
      }
      if(this.select_list.selValue == -1)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("80137",8));
         return;
      }
      if(UIManager.mainUiBtnContainer.curFuBenType != 0 || Global.sceneID == 12304)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("80169",8));
         return;
      }
      if(GameUnitManager.hero.paoBiao != 0)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("80170",8));
         return;
      }
      QiJuCGMessage.CG_GREAT_QIJU_TEAM(int(this.select_list.selValue));
   }
   
   override public function set visible(value:Boolean) : void
   {
      super.visible = value;
      if(value && Boolean(this.select_list))
      {
         View_JoinQiJu.instance.upDataGrid(this.type);
      }
   }
}

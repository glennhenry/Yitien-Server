package com.yiTian.view.modules.qingMing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QingmingCGMessage;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   
   public class View_zhuaGuiPanel extends Panel123
   {
      
      private var _bg:DisplayObject;
      
      private var _tfTaskDecript:MyTextField;
      
      private var _tfGuiLing:MyTextField;
      
      private var _tfItem:MyTextField;
      
      private var _btnRefresh:Button;
      
      private var _tfTimes:MyTextField;
      
      private var _btnAcceptTask:Button;
      
      private var _gridReward:View_Grid;
      
      private var _tfTargetMap:MyTextField;
      
      private var _tfQuality:MyTextField;
      
      private var _ghosts:Array = [];
      
      private var isCanGo:Boolean;
      
      private var ghost:Npc;
      
      private var isInit:Boolean;
      
      private var seleteBg:ScaleBitmap;
      
      private var seletePos:Array = [41,41,41 + 144 * 1,41 + 144 * 2,41 + 144 * 3];
      
      private var taskStr:String;
      
      private var helBtn:Button;
      
      private var bgOverArr:Array = [];
      
      private var refreshText:MyTextField;
      
      public function View_zhuaGuiPanel()
      {
         super();
         regResource("lang/ch/ZhuaGui.swf","ZhuaGuidm");
      }
      
      public static function get instance() : View_zhuaGuiPanel
      {
         return Singleton.getInstance(View_zhuaGuiPanel);
      }
      
      public static function checkVisible() : void
      {
         if(Boolean(Model_QingMing.bindNpc))
         {
            if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,Model_QingMing.bindNpc.global_x,Model_QingMing.bindNpc.global_y) >= 60000)
            {
               Model_QingMing.bindNpc = null;
               instance.hide();
            }
         }
      }
      
      override protected function initUI2() : void
      {
         var bgOver:ScaleBitmap = null;
         var i:int = 0;
         var ghost:Child_tianTiUnit = null;
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":647,
            "height":482
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_QMZhuaGui",this,{
            "x":243,
            "y":5
         },Global.ZhuaGuidm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":41,
            "width":599,
            "height":432
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":26,
            "y":44,
            "width":594,
            "height":426
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_ZuaGui",[16,18,1,1],this,{
            "x":29,
            "y":47,
            "width":588,
            "height":195
         },Global.ZhuaGuidm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":41,
            "y":55,
            "width":132,
            "height":164
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":185,
            "y":55,
            "width":132,
            "height":164
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":328,
            "y":54,
            "width":132,
            "height":164
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":473,
            "y":55,
            "width":132,
            "height":164
         },Global.Img_Cdm);
         this.seleteBg = ComponentUtil.getScaleBitmap("Back_FaGuang",[5,5,1,1],this,{
            "x":24,
            "y":55,
            "width":132,
            "height":164
         },Global.ZhuaGuidm);
         ComponentUtil.getBitmap("BG_Line03",this,{
            "x":51,
            "y":241
         },Global.ZhuaGuidm);
         ComponentUtil.getTextField("经验果*10",this,{
            "x":78,
            "y":220,
            "color":3461909
         });
         ComponentUtil.getTextField("经验果*13",this,{
            "x":218,
            "y":220,
            "color":3709371
         });
         ComponentUtil.getTextField("经验果*16",this,{
            "x":366,
            "y":220,
            "color":14566855
         });
         ComponentUtil.getTextField("经验果*20",this,{
            "x":504,
            "y":220,
            "color":16485417
         });
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":41,
            "y":281,
            "width":564,
            "height":175
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_QMSJ",this,{
            "x":200,
            "y":249
         },Global.ZhuaGuidm);
         ComponentUtil.getBitmap("BG_RenWu",this,{
            "x":54,
            "y":286
         },Global.ZhuaGuidm);
         ComponentUtil.getBitmap("BG_RenWu",this,{
            "x":54,
            "y":342
         },Global.ZhuaGuidm);
         ComponentUtil.getTextField("任务描述:",this,{
            "x":61,
            "y":287,
            "color":14211192
         });
         ComponentUtil.getTextField("厉鬼品质:",this,{
            "x":63,
            "y":343,
            "color":14211192
         });
         ComponentUtil.getTextField("奖励:",this,{
            "x":86,
            "y":374,
            "color":14211192,
            "size":12
         });
         ComponentUtil.getTextField("今日可领取次数:",this,{
            "x":63,
            "y":421,
            "color":14211192
         });
         ComponentUtil.getBitmap("BG_Line02",this,{
            "x":59,
            "y":335
         },Global.ZhuaGuidm);
         ComponentUtil.getBitmap("BG_Line02",this,{
            "x":59,
            "y":403
         },Global.ZhuaGuidm);
         ComponentUtil.getButton("","BT_JSRenWu",this,{
            "x":490,
            "y":418,
            "callBack":this.btnAcceptClickHd
         },Global.ZhuaGuidm);
         this._btnRefresh = ComponentUtil.getButton("","BT_SXLiGui",this,{
            "x":497,
            "y":353,
            "textColor":16771436,
            "callBack":this.refreshClickHd
         },Global.ZhuaGuidm);
         this.refreshText = ComponentUtil.getTextField("",this,{
            "x":504,
            "y":357
         });
         this.refreshText.htmlText = "刷新厉鬼品质\n(20000银两)";
         ComponentUtil.getTextField("接受任务",this,{
            "x":517,
            "y":421,
            "color":16184781
         });
         this._gridReward = new View_Grid();
         this._gridReward.x = 145;
         this._gridReward.y = 363;
         this._gridReward.set_bmp_bg();
         this._gridReward.set_bmp_over(true,null);
         this._gridReward.set_tf_count(true,false,true);
         addChild(this._gridReward);
         this._tfQuality = ComponentUtil.getTextField("",this,{
            "x":136,
            "y":342
         });
         this._tfTargetMap = ComponentUtil.getTextField("",this,{
            "x":144,
            "y":307
         });
         this._tfTargetMap.mouseEnabled = true;
         this._tfTargetMap.addEventListener(TextEvent.LINK,this.onLink);
         this._tfTargetMap.htmlText = "刷新的厉鬼会在【潼关】、【安州】、【绿柳庄】随机出现";
         this._tfTimes = ComponentUtil.getTextField("10/10",this,{
            "x":154,
            "y":421,
            "color":3461909,
            "size":12
         });
         ComponentUtil.getTextField("难度较高，建议组队领取任务（奖励更高）",this,{
            "x":225,
            "y":366,
            "color":3461909,
            "size":12
         });
         ComponentUtil.getBitmap("BG_Gui1",this,{
            "x":51,
            "y":119
         },Global.ZhuaGuidm);
         ComponentUtil.getBitmap("BG_Gui2",this,{
            "x":194,
            "y":119
         },Global.ZhuaGuidm);
         ComponentUtil.getBitmap("BG_Gui3",this,{
            "x":338,
            "y":119
         },Global.ZhuaGuidm);
         ComponentUtil.getBitmap("BG_Gui4",this,{
            "x":481,
            "y":119
         },Global.ZhuaGuidm);
         i = 0;
         while(i < 4)
         {
            ghost = new Child_tianTiUnit();
            ghost.type = Child_tianTiUnit.GHOST;
            ghost.modelId = Model_QingMing.modelIdArr[i];
            ghost.way = 4;
            ghost.x = 106 + 144 * i;
            if(i == 3)
            {
               ghost.x = 120 + 144 * i;
               ghost.scaleX = ghost.scaleY = 0.7;
            }
            if(i == 2)
            {
               ghost.x = 100 + 144 * i;
               ghost.y = 225;
               ghost.scaleX = ghost.scaleY = 0.8;
            }
            else
            {
               ghost.y = 188;
            }
            TipManager.bind(ghost,"<font color=\'" + Model_QingMing.ghostNameColorArr[i] + "\'>" + Model_QingMing.ghostNameArr[i + 1] + "</font>");
            bgOver = ComponentUtil.getScaleBitmap("Back_FaGuang",[5,5,1,1],this,{
               "x":this.seletePos[i + 1],
               "y":55,
               "width":132,
               "height":164
            },Global.ZhuaGuidm);
            bgOver.visible = false;
            this.bgOverArr[ghost.modelId] = bgOver;
            ghost.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
            ghost.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            ghost.setFrameInterval(150);
            addChild(ghost);
            this._ghosts.push(ghost);
            i += 1;
         }
         move = new Rectangle(0,0,this._bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":609,
            "y":6,
            "callBack":this.hide
         },Global.Img_Cdm);
         Model_QingMing.setStaticData();
         Global.control.registerCallBack(Msg_QingMing.QUALITY_UPDATE,this.updateGhostLv);
         Global.control.registerCallBack(Msg_QingMing.REMAIN_UPDATE,this.updateRemain);
         if(!Global.control.hasCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onEnterSceneOk))
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onEnterSceneOk);
         }
         this.helBtn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":609 - 28,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(this.helBtn,"1.<font color=\'#ffff33\'>抓鬼任务每天可完成</font>10<font color=\'#ffff33\'>次。</font><br/>" + "2.<font color=\'#ffff33\'>可使用银两刷新鬼的品质，品质越高奖励越高。</font><br/>" + "3.<font color=\'#ffff33\'>多人组队经验越高。</font><br/>" + "4.<font color=\'#ffff33\'>成功抓捕鬼后，自动完成任务。</font>");
         this.isInit = true;
      }
      
      private function onOut(e:MouseEvent) : void
      {
         this.bgOverArr[(e.currentTarget as Child_tianTiUnit).modelId].visible = false;
      }
      
      private function onOver(e:MouseEvent) : void
      {
         this.bgOverArr[(e.currentTarget as Child_tianTiUnit).modelId].visible = true;
      }
      
      public function onEnterSceneOk() : void
      {
         this.removeGui();
         if(Boolean(Model_QingMing.data) && Boolean(Model_QingMing.data.length))
         {
            if(Global.sceneID == Model_QingMing.data[2])
            {
               this.addGui();
            }
         }
      }
      
      public function removeGui() : void
      {
         if(Boolean(this.ghost))
         {
            GameUnitManager.removeUnit(this.ghost);
            this.ghost = null;
         }
      }
      
      public function addGui() : void
      {
         if(Boolean(Model_QingMing.data) && Boolean(Model_QingMing.data.length))
         {
            this.ghost = new Npc();
            this.ghost.init(Model_QingMing.data[0],Model_QingMing.data[1],Model_QingMing.data[3],Model_QingMing.data[4],10000,10000,10000,10000,4,[],[]);
            this.ghost.npcType = Enum_npc_type.GHOST;
            if(Model_team.teamMumberInfo_data_save.length > 0)
            {
               this.ghost.name = "<font color=\'#33CCFF\'>" + Model_team.teamMumberInfo_data_save[0][7] + "</font>的<font color=\'" + Model_QingMing.ghostNameColorArr[Model_QingMing._curLv - 1] + "\'>" + this.ghost.name + "</font>";
            }
            else
            {
               this.ghost.name = "<font color=\'#33CCFF\'>" + GameUnitManager.hero.name + "</font>的<font color=\'" + Model_QingMing.ghostNameColorArr[Model_QingMing._curLv - 1] + "\'>" + this.ghost.name + "</font>";
            }
            GameUnitManager.addUnit(this.ghost);
         }
      }
      
      private function refreshClickHd(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < int(Model_QingMing.silverArr[Model_QingMing._curLv]))
         {
            UIManager.centerBroadcast.addMsg("银子不够");
            return;
         }
         QingmingCGMessage.CG_QINGMING_REFRESH_QUALITY();
      }
      
      private function btnAcceptClickHd(e:MouseEvent) : void
      {
         QuestCGMessage.CG_QUEST_ACCEPT(Msg_QingMing.QUEST_ID);
         Model_QingMing.needFresh = true;
         this.hide();
      }
      
      public function updateTargetMap(id:int, monsterId:int, sceneId:int, x:int, y:int) : void
      {
         if(sceneId == 0)
         {
            return;
         }
         this.removeGui();
         Model_QingMing.data = [id,monsterId,sceneId,x,y];
         var nearX:int = int(x / 20) + Math.random() * 60 - 10;
         var nearY:int = int(y / 20) + Math.random() * 60 - 10;
         Model_QingMing._curLv = Model_QingMing.ghostNameArr.indexOf(Data_lib.npc[monsterId][Npc.NAME]);
         this.taskStr = Util.rep("前往<font color=\'#ffff33\'>{0}(" + nearX + "," + nearY + "附近)</font>抓捕{1}",HtmlUtil.fontNoSize(Data_lib.map[sceneId][0],"#dddd33"),HtmlUtil.fontNoSize(Data_lib.npc[monsterId][Npc.NAME],Model_QingMing.ghostNameColorArr[Model_QingMing._curLv - 1]));
         UIManager.questTraceView.update();
         if(Model_QingMing.needFresh == true)
         {
            UIManager.centerBroadcast.addMsg(this.taskStr);
         }
         GameUnitManager.hero.lockTarget = null;
         if(Global.sceneID == sceneId)
         {
            this.addGui();
         }
         if(this.isInit == false)
         {
            return;
         }
         var areaTxt:String = HtmlUtil.fontNoSize(HtmlUtil.createLink(Data_lib.map[sceneId][0],true,"go_" + sceneId + "_" + x + "_" + y),"#dddd33");
         var guiLingTxt:String = HtmlUtil.fontNoSize(HtmlUtil.createLink(Data_lib.npc[monsterId][Npc.NAME],true,"go_" + sceneId + "_" + x + "_" + y),Model_QingMing.ghostNameColorArr[Model_QingMing._curLv - 1]);
         this._tfTargetMap.htmlText = Util.rep("前往<font color=\'#ffff33\'>{0}</font>抓捕{1}",areaTxt,guiLingTxt);
      }
      
      public function getTaskStr() : String
      {
         if(!this.taskStr)
         {
            return "";
         }
         return this.taskStr;
      }
      
      public function updateGhostLv() : void
      {
         var lv:int = 0;
         var vo:Vo_item = null;
         var len:int = 0;
         if(this.isInit == false)
         {
            return;
         }
         lv = Model_QingMing._curLv;
         var label:Array = ["","绿色-鬼灵","蓝色-鬼将","紫色-鬼王","橙色-鬼仙"];
         if(lv == Msg_QingMing.MAX_LV)
         {
            this._btnRefresh.enabled = false;
         }
         else
         {
            this._btnRefresh.enabled = true;
         }
         if(lv > 0)
         {
            vo = new Vo_item();
            vo.id = Msg_QingMing.EXP_ITEM_ID;
            vo.Init_lib();
            len = int(Model_team.teamMumberInfo_data_save.length);
            vo.count = Data_lib.zhuaGuiReward[lv][len == 0 ? 0 : len - 1];
            this._gridReward.vo = vo;
         }
         else
         {
            this._gridReward.vo = null;
         }
         this.seleteBg.x = this.seletePos[lv];
         this.refreshText.htmlText = "刷新厉鬼品质\n(" + (lv == Msg_QingMing.MAX_LV ? "已是最高级)" : Model_QingMing.silverArr[lv] + "银子)");
         this._tfQuality.htmlText = Enum_BroadCastTool.instance.getColorStr(label[lv],lv + 1);
      }
      
      public function updateRemain() : void
      {
         if(this.isInit == false)
         {
            return;
         }
         var remain:int = Model_QingMing._refreshTimes;
         this._tfTimes.text = remain.toString() + "/" + (10).toString();
      }
      
      private function onLink(e:TextEvent) : void
      {
         var arr:Array = e.text.split("_");
         GameUnitManager.hero.autoMoveLocation(arr[1]);
      }
      
      public function show(prm:* = null) : void
      {
         visible = true;
         UIManager.questDialog.visible = false;
         this._tfTargetMap.htmlText = "<font color=\'#ffff33\'>刷新的厉鬼会在【应天府】、【蜀皇堡】、【清水寨】随机出现</font>";
         Global.control.sendNotification(Msg_QingMing.QUALITY_UPDATE,Model_QingMing._curLv);
         Global.control.sendNotification(Msg_QingMing.REMAIN_UPDATE,Model_QingMing._refreshTimes);
         pop(Global.stage.mouseX / Global.stage.stageWidth,Global.stage.mouseY / Global.stage.stageHeight);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      public function hide(prm:* = null) : void
      {
         visible = false;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      private function onFrame(i:int) : void
      {
         var ghost:Child_tianTiUnit = null;
         for each(ghost in this._ghosts)
         {
            ghost.onFrame(i);
         }
      }
   }
}


package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_KuaFuJingJiChang;
   import com.yiTian.data.vo.Vo_ZhenFa;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.team.MemberVO;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class DRKFlawPanel extends Panel123
   {
      
      private static var _instance:DRKFlawPanel;
      
      private static var startX:int;
      
      private static var startY:int;
      
      private var back:ScaleBitmap;
      
      private var qian1:Bitmap;
      
      private var qian2:Bitmap;
      
      private var qian3:Bitmap;
      
      private var zhong1:Bitmap;
      
      private var zhong2:Bitmap;
      
      private var zhong3:Bitmap;
      
      private var hou1:Bitmap;
      
      private var hou2:Bitmap;
      
      private var hou3:Bitmap;
      
      private var jianBtn:Button;
      
      private var jiaBtn:Button;
      
      private var yixueLaw:MyTextField;
      
      private var weixueLaw:MyTextField;
      
      private var yixuetitle:Bitmap;
      
      private var weixuetitle:Bitmap;
      
      private var zfContainer:Canvas;
      
      private var zf1:Sprite;
      
      private var zf2:Sprite;
      
      private var zftitle1:Sprite;
      
      private var zftitle2:Sprite;
      
      private var len:int;
      
      private var index2:int;
      
      private var lawArr:Vector.<DRKFlawItem> = new Vector.<DRKFlawItem>();
      
      private var gridArr:Vector.<MyZFGrid> = new Vector.<MyZFGrid>();
      
      private var zhenxingArr:Array = new Array();
      
      private var nowzhenfa:MyTextField;
      
      private var bcBtn:Button;
      
      private var qxBtn:Button;
      
      private var curZhenFaId:int = 80101;
      
      private var curSelZf:DRKFlawItem;
      
      private var _curDargGrid:MyZFGrid;
      
      private var dragSp:Sprite;
      
      private var dragSpsBm:Bitmap;
      
      private var bitmapArr:Vector.<Bitmap> = new Vector.<Bitmap>();
      
      private var b:Array = [];
      
      public function DRKFlawPanel()
      {
         super();
         regResource("lang/ch/DuoRenKuaFu_Imgs.swf","DuoRenKuaFu_Imgsdm");
      }
      
      public static function get instance() : DRKFlawPanel
      {
         if(!_instance)
         {
            _instance = new DRKFlawPanel();
         }
         return _instance;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var j:int = 0;
         var grid:MyZFGrid = null;
         bindParent = GameScene.modalLayer;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":456,
            "height":397
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":408,
            "height":347
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":388,
            "height":289
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":286,
            "y":93,
            "width":127,
            "height":237
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":422,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.hide;
         ComponentUtil.getBitmap("Title_ZhenXing",this,{
            "x":144,
            "y":5
         },Global.DuoRenKuaFu_Imgsdm);
         ComponentUtil.getBitmap("Back_Set_Team",this,{
            "x":44,
            "y":93
         },Global.DuoRenKuaFu_Imgsdm);
         ComponentUtil.getBitmap("Text_Set",this,{
            "x":35,
            "y":51
         },Global.DuoRenKuaFu_Imgsdm);
         this.qian1 = ComponentUtil.getBitmap("Set_GridFront",this,{
            "x":59,
            "y":108
         },Global.DuoRenKuaFu_Imgsdm);
         this.qian2 = ComponentUtil.getBitmap("Set_GridFront",this,{
            "x":133,
            "y":108
         },Global.DuoRenKuaFu_Imgsdm);
         this.qian3 = ComponentUtil.getBitmap("Set_GridFront",this,{
            "x":207,
            "y":108
         },Global.DuoRenKuaFu_Imgsdm);
         this.zhong1 = ComponentUtil.getBitmap("Set_GridMind",this,{
            "x":59,
            "y":182
         },Global.DuoRenKuaFu_Imgsdm);
         this.zhong2 = ComponentUtil.getBitmap("Set_GridMind",this,{
            "x":133,
            "y":182
         },Global.DuoRenKuaFu_Imgsdm);
         this.zhong3 = ComponentUtil.getBitmap("Set_GridMind",this,{
            "x":207,
            "y":182
         },Global.DuoRenKuaFu_Imgsdm);
         this.hou1 = ComponentUtil.getBitmap("Set_GridBack",this,{
            "x":59,
            "y":256
         },Global.DuoRenKuaFu_Imgsdm);
         this.hou2 = ComponentUtil.getBitmap("Set_GridBack",this,{
            "x":133,
            "y":256
         },Global.DuoRenKuaFu_Imgsdm);
         this.hou3 = ComponentUtil.getBitmap("Set_GridBack",this,{
            "x":207,
            "y":256
         },Global.DuoRenKuaFu_Imgsdm);
         this.nowzhenfa = ComponentUtil.getTextField("当前阵法：阵法中文名称",this,{
            "x":56,
            "y":353,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.bcBtn = ComponentUtil.getButton("保存设置","Button_Orange",this,{
            "x":243,
            "y":350,
            "textColor":16184781
         },Global.Img_Cdm);
         this.qxBtn = ComponentUtil.getButton("取消阵法","Button_Orange",this,{
            "x":334,
            "y":350,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bcBtn.addEventListener(MouseEvent.CLICK,this.bcClick);
         this.qxBtn.addEventListener(MouseEvent.CLICK,this.qxClick);
         i = 0;
         while(i < 3)
         {
            j = 0;
            while(j < 3)
            {
               grid = new MyZFGrid(false,".jpg");
               grid.type = Enum_type_grid.KFJJ_ZF;
               grid.set_bmp_select();
               grid.set_bmp_bg("resource/image/team/zxBg.png");
               grid.set_bmp_over(true,"resource/image/team/grid_Skill_over.png");
               grid.set_tf_count(true,false,true);
               grid.x = 216 - 74 * j;
               grid.y = 117 + 74 * i;
               grid.index = i * 3 + j;
               addChild(grid);
               this.gridArr.push(grid);
               grid.posStr = ((i + 1) * 10 + j + 1).toString();
               grid.addEventListener(MouseEvent.MOUSE_DOWN,this.gridMouseDownHd);
               grid.addEventListener(MouseEvent.MOUSE_UP,this.gridMouseUpHd);
               j++;
            }
            i++;
         }
         this.setZFID(this.curZhenFaId);
         this.zfContainer = new Canvas(120,232);
         this.zfContainer.x = 287;
         this.zfContainer.y = 95;
         addChild(this.zfContainer);
         this.zfContainer.scrollAutoType = ScrollAutoType.REMAIN;
         this.zftitle1 = new Sprite();
         this.zftitle2 = new Sprite();
         this.zf1 = new Sprite();
         this.yixuetitle = ComponentUtil.getBitmap("Back_Title",this,{
            "x":0,
            "y":0
         },Global.DuoRenKuaFu_Imgsdm);
         this.jianBtn = ComponentUtil.getButton("","Button_Jian",this,{
            "x":1,
            "y":1,
            "textColor":16184781
         },Global.DuoRenKuaFu_Imgsdm);
         this.yixueLaw = ComponentUtil.getTextField("已学会阵法",this,{
            "x":25,
            "y":2,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.zftitle1.addChild(this.yixuetitle);
         this.zftitle1.addChild(this.jianBtn);
         this.zftitle1.addChild(this.yixueLaw);
         this.zfContainer.addChild(this.zftitle1);
         this.jianBtn.addEventListener(MouseEvent.CLICK,this.jianBtnClick);
         this.initDynamicView();
      }
      
      private function childzf1() : void
      {
         var i:int = 0;
         var id:int = 0;
         var law:DRKFlawItem = null;
         this.len = (Model_KuaFuJingJiChang.myTeamVo[0] as MyTeamVo).zhenFaArr.length;
         this.zf1.y = 22;
         this.lawArr.length = 0;
         i = 0;
         while(i < this.len)
         {
            id = parseInt((Model_KuaFuJingJiChang.myTeamVo[0] as MyTeamVo).zhenFaArr[i]);
            law = new DRKFlawItem();
            law.x = 0;
            law.y = 45 * i;
            law.zfId = id;
            law.LawName.text = Data_lib.zhenfa[id][2];
            law.LawLevel.text = Data_lib.zhenfa[id][1] + "级";
            Utils.getLoadBitmap("resource/image/icon/" + Data_lib.zhenfa[id][8] + ".png",law.img);
            this.zf1.addChild(law);
            this.lawArr.push(law);
            i++;
         }
         this.zfContainer.addChild(this.zf1);
         this.childzf2();
      }
      
      public function setSelZf(selZf:DRKFlawItem) : void
      {
         if(Boolean(this.curSelZf))
         {
            this.curSelZf.grid.bSelect = false;
            this.curSelZf.selected = false;
            this.curSelZf = null;
         }
         this.curSelZf = selZf;
         this.curSelZf.grid.bSelect = true;
         this.curSelZf.selected = true;
         this.curZhenFaId = this.curSelZf.zfId;
         this.setZFID(this.curZhenFaId);
      }
      
      public function zhenxing() : void
      {
         var i:int = 0;
         while(i < this.lawArr.length)
         {
            if(this.lawArr[i].selected)
            {
               this.curZhenFaId = this.lawArr[i].zfId;
               this.setZFID(this.curZhenFaId);
            }
            i++;
         }
      }
      
      private function remove1() : void
      {
         this.lawArr.length = 0;
         this.zfContainer.removeChild(this.zf1);
         this.len = 0;
         this.childzf2();
      }
      
      private function open() : void
      {
         this.setZFID(this.curZhenFaId,true);
         if(Boolean(this.zf1))
         {
            this.zfContainer.removeChild(this.zf1);
         }
         if(Boolean(this.zf2))
         {
            this.zfContainer.removeChild(this.zf2);
         }
         this.childzf1();
      }
      
      private function gridMouseDownHd(e:MouseEvent) : void
      {
         var mVO:MemberVO = null;
         var dragGrid:MyZFGrid = UIManager.dragObj.grid as MyZFGrid;
         var targetGrid:MyZFGrid = e.target as MyZFGrid;
         if(UIManager.isDrag && Boolean(dragGrid))
         {
            mVO = dragGrid.vo as MemberVO;
            if(Boolean(dragGrid.type == Enum_type_grid.ZHENXING) && Boolean(mVO) && Boolean(mVO.str_icon))
            {
               dragGrid.vo = targetGrid.vo;
               targetGrid.vo = mVO;
            }
         }
      }
      
      private function gridMouseUpHd(e:MouseEvent) : void
      {
         var mVO:MemberVO = null;
         var dragGrid:MyZFGrid = UIManager.dragObj.grid as MyZFGrid;
         var targetGrid:MyZFGrid = e.target as MyZFGrid;
         if(UIManager.isDrag && Boolean(dragGrid))
         {
            mVO = dragGrid.vo as MemberVO;
            if(Boolean(dragGrid.type == Enum_type_grid.KFJJ_ZF) && Boolean(mVO) && Boolean(mVO.str_icon))
            {
               dragGrid.vo = targetGrid.vo;
               if(Boolean(dragGrid.vo as MyMenberVo))
               {
                  (dragGrid.vo as MyMenberVo).posStr = dragGrid.posStr;
               }
               targetGrid.vo = mVO;
               (targetGrid.vo as MyMenberVo).posStr = targetGrid.posStr;
            }
         }
      }
      
      private function childzf2() : void
      {
         var id2:int = 0;
         var law2:DRKFlawItem = null;
         if(!this.zf2)
         {
            this.zf2 = new Sprite();
            this.weixuetitle = ComponentUtil.getBitmap("Back_Title",this,{
               "x":0,
               "y":0
            },Global.DuoRenKuaFu_Imgsdm);
            this.weixueLaw = ComponentUtil.getTextField("未学会阵法",this,{
               "x":25,
               "y":2,
               "color":16184781,
               "size":12,
               "leading":0
            });
            this.jiaBtn = ComponentUtil.getButton("","Button_Jia",this,{
               "x":1,
               "y":1,
               "textColor":16184781
            },Global.DuoRenKuaFu_Imgsdm);
         }
         this.zftitle2.y = 45 * this.len + 22;
         this.zftitle2.addChild(this.weixuetitle);
         this.zftitle2.addChild(this.weixueLaw);
         this.zftitle2.addChild(this.jiaBtn);
         this.zfContainer.addChild(this.zftitle2);
         this.jiaBtn.addEventListener(MouseEvent.CLICK,this.jiaBtnClick);
         var j:int = 0;
         while(j < (Model_KuaFuJingJiChang.myTeamVo[0] as MyTeamVo).notZhenFaArr.length)
         {
            id2 = parseInt((Model_KuaFuJingJiChang.myTeamVo[0] as MyTeamVo).notZhenFaArr[j]);
            if(id2 != 0)
            {
               law2 = new DRKFlawItem();
               law2.x = 0;
               law2.y = 45 * j;
               law2.zfId = id2;
               law2.LawName.htmlText = "<font color= \'#ff0000\'>" + Data_lib.zhenfa[id2][2] + "</font>";
               law2.LawLevel.text = Data_lib.zhenfa[id2][1] + "级";
               Utils.getLoadBitmap("resource/image/icon/" + id2 + ".png",law2.img);
               this.zf2.addChild(law2);
               this.lawArr.push(law2);
            }
            j++;
         }
         this.zf2.y = this.zftitle2.y + 20;
         this.zfContainer.addChild(this.zf2);
         this.zfContainer.align();
         this.weixueSpr();
      }
      
      public function grid() : void
      {
         var i:int = 0;
         while(i < this.lawArr.length)
         {
            this.lawArr[i].grid.bSelect = false;
            this.lawArr[i].selected = false;
            i++;
         }
      }
      
      public function setZFID(v:int, bUseData:Boolean = false) : Boolean
      {
         var info:Array = Data_lib.zhenfa[v];
         if(!info)
         {
            return false;
         }
         this.updateGridsEnabeld(bUseData);
         return true;
      }
      
      public function updateGridsEnabeld(bUseData:Boolean = false) : void
      {
         var i:int = 0;
         var aPossInfo:Array = null;
         var n:uint = 0;
         var str:String = null;
         var vos:Vector.<MyTeamVo> = null;
         var ii:int = 0;
         var yIndex:int = 0;
         var xIndex:int = 0;
         var index:int = 0;
         var player:MyMenberVo = null;
         var pet:MyMenberVo = null;
         var member:MyMenberVo = null;
         var px:int = 0;
         var py:int = 0;
         var tmp:Array = null;
         var voo:MyMenberVo = null;
         var grid:MyZFGrid = null;
         var teamMember:MyMenberVo = null;
         var vo:Vo_ZhenFa = new Vo_ZhenFa(this.curZhenFaId);
         var a:Array = vo.weizhi.split(",");
         this.nowzhenfa.text = "当前阵法：" + vo.name;
         var possInfo:Array = Util.splicObj(KuaFuJJCVO.weiZhi || GameUnitManager.hero.id + "_" + "11_12","|_") as Array;
         var kArr:Object = {};
         for each(aPossInfo in possInfo)
         {
            kArr[aPossInfo[0]] = aPossInfo;
         }
         n = 0;
         while(n < this.gridArr.length)
         {
            this.gridArr[n].enable = false;
            this.gridArr[n].vo = null;
            this.gridArr[n].removeEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
            this.gridArr[n].removeEventListener(MouseEvent.MOUSE_UP,this.gridMouseUpHd);
            n++;
         }
         for each(str in a)
         {
            yIndex = int(str) / 10 - 1;
            xIndex = int(str) % 10 - 1;
            index = xIndex + yIndex * 3;
            this.gridArr[index].enable = true;
            this.gridArr[index].addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
            this.gridArr[index].addEventListener(MouseEvent.MOUSE_UP,this.gridMouseUpHd);
         }
         vos = Model_KuaFuJingJiChang.myTeamVo;
         this.b.length = 0;
         ii = 0;
         while(ii < vos.length)
         {
            player = new MyMenberVo();
            player.id = vos[ii].id;
            player.str_name = player.name = vos[ii].name;
            player.level = vos[ii].level;
            player.job = vos[ii].job;
            player.hp = vos[ii].heroHpArr[0];
            player.hpMax = vos[ii].heroHpArr[1];
            player.mp = vos[ii].heroMpArr[0];
            player.mpMax = vos[ii].heroMpArr[1];
            player.str_icon = vos[ii].str_icon;
            player.type = MyMenberVo.TYPE_PLAYER;
            player.memberOrPet = true;
            if(kArr[player.id] != null)
            {
               player.posStr = kArr[player.id][1];
            }
            this.b.push(player);
            if(Boolean(vos[ii].petId))
            {
               pet = new MyMenberVo();
               pet.memberOrPet = false;
               pet.str_icon = vos[ii].petId + "_40";
               pet.str_name = pet.name = vos[ii].petName;
               pet.level = vos[ii].petLevel;
               pet.hp = vos[ii].petHpArr[0];
               pet.hpMax = vos[ii].petHpArr[1];
               player.pet = pet;
               this.b.push(pet);
               if(kArr[player.id] != null)
               {
                  pet.posStr = kArr[player.id][2];
               }
            }
            ii += 1;
         }
         if(bUseData)
         {
            for each(member in this.b)
            {
               px = int(member.posStr.charAt(1));
               py = int(member.posStr.charAt(0));
               this.gridArr[(py - 1) * 3 + (px - 1)].vo = member;
            }
         }
         else
         {
            tmp = [];
            i = 0;
            while(i < 9)
            {
               voo = this.b[i];
               grid = this.gridArr[i];
               if(voo != null)
               {
                  tmp.push(voo);
               }
               if(grid.enable && Boolean(tmp.length))
               {
                  teamMember = tmp.shift() as MyMenberVo;
                  grid.vo = teamMember;
                  teamMember.posStr = grid.posStr;
               }
               i += 1;
            }
         }
      }
      
      public function getstr() : String
      {
         var vo:MyMenberVo = null;
         var strs:Array = [];
         for each(vo in this.b)
         {
            if(vo.type == MyMenberVo.TYPE_PLAYER)
            {
               strs.push(vo.id.toString() + "_" + vo.posStr + "_" + (vo.pet != null ? vo.pet.posStr : "0"));
            }
         }
         return strs.join("|");
      }
      
      private function remove2() : void
      {
         this.zfContainer.removeChild(this.zf2);
      }
      
      private function bcClick(e:MouseEvent) : void
      {
         var s:String = this.getstr();
         KuaFuJingJiChangCGMessage.CG_BIANHUAN_LAW(this.curZhenFaId,s);
      }
      
      private function qxClick(e:MouseEvent) : void
      {
         var i:int = 0;
         while(i < this.lawArr.length)
         {
            if(this.lawArr[i].selected)
            {
               this.lawArr[i].selected = false;
            }
            i++;
         }
         this.lawArr[0].selected = true;
         this.curZhenFaId = Math.max(80101);
         this.setZFID(this.curZhenFaId);
         var s:String = this.getstr();
         KuaFuJingJiChangCGMessage.CG_BIANHUAN_LAW(this.curZhenFaId,s);
      }
      
      private function jianBtnClick(e:MouseEvent) : void
      {
         if(this.jianBtn.style == "Button_Jian")
         {
            this.remove1();
            this.jianBtn.style = "Button_Jia";
         }
         else
         {
            this.childzf1();
            this.jianBtn.style = "Button_Jian";
         }
         this.weixueSpr();
         this.zfContainer.align();
      }
      
      private function weixueSpr() : void
      {
         if(this.jiaBtn.style == "Button_Jian")
         {
            this.zfContainer.addChild(this.zf2);
         }
         else
         {
            this.zfContainer.removeChild(this.zf2);
         }
         this.zfContainer.align();
      }
      
      private function jiaBtnClick(e:MouseEvent) : void
      {
         if(this.jiaBtn.style == "Button_Jian")
         {
            this.jiaBtn.style = "Button_Jia";
         }
         else
         {
            this.jiaBtn.style = "Button_Jian";
         }
         this.weixueSpr();
      }
      
      public function show() : void
      {
         ModalUIManager.POPUP(this,"center",false);
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      private function onAskSceneOk() : void
      {
         this.hide();
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,arguments.callee);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,arguments.callee);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.open();
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onAskSceneOk);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onAskSceneOk);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onAskSceneOk);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onAskSceneOk);
         }
      }
   }
}

import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.team.MemberVO;
import flash.display.Bitmap;

class MyMenberVo extends MemberVO
{
   
   public static const TYPE_PLAYER:int = 1;
   
   public static const TYPE_PET:int = 2;
   
   public var type:int;
   
   public var curPosStr:String;
   
   public var pet:MyMenberVo;
   
   public var posStr:String;
   
   public function MyMenberVo()
   {
      super();
   }
}

class MyZFGrid extends View_Grid
{
   
   public var posStr:String;
   
   public var _enabled:Boolean = true;
   
   public var _bitmap:Bitmap;
   
   public function MyZFGrid($bBigIcon:Boolean = false, str_extend_name:String = ".png")
   {
      super($bBigIcon,str_extend_name);
   }
   
   public function get enable() : Boolean
   {
      return this._enabled;
   }
   
   public function set enable(v:Boolean) : void
   {
      if(!v)
      {
         set_grey(true);
      }
      else
      {
         set_grey(false);
      }
      this._enabled = v;
   }
   
   public function get bitmap() : Bitmap
   {
      if(!this._bitmap)
      {
         this._bitmap = new Bitmap();
         var _temp_1:* = this._bitmap;
         this._bitmap.scaleY = 0.85;
         _temp_1.scaleX = 0.85;
         addChild(this._bitmap);
      }
      return this._bitmap;
   }
   
   public function set bitmap(b:Bitmap) : void
   {
      b = new Bitmap();
      this._bitmap = b;
   }
}

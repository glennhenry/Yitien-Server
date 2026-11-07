package com.yiTian.view.modules.broadcast
{
   import com.utils.ColorConstant;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_lib_equip;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.horse.HorseConfig;
   import com.yiTian.view.modules.shenBing.Enum_ShenBing;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   
   public class Enum_BroadCastTool
   {
      
      private static var _instance:Enum_BroadCastTool;
      
      private var dic:Dictionary;
      
      private var colorDic:Dictionary;
      
      private var funcDic:Dictionary;
      
      private var patch:IDataInput;
      
      private var readTypeArr:Array;
      
      private var funKeyArr:Array;
      
      private var ii:int;
      
      public function Enum_BroadCastTool()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singleton error");
         }
         this.init();
         _instance = this;
      }
      
      public static function get instance() : Enum_BroadCastTool
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      private function initColorDic() : void
      {
         this.colorDic = new Dictionary();
         this.colorDic["%Cy"] = "<font color = \'#ffff00\'>";
         this.colorDic["%Cr"] = "<font color = \'#DB4747\'>";
         this.colorDic["%Cg"] = "<font color = \'#00ff00\'>";
         this.colorDic["%Csg"] = "<font color = \'#33CCFF\'>";
         this.colorDic["%Cb"] = "<font color = \'#0000ff\'>";
         this.colorDic["%Cz"] = "<font color = \'#bb00ff\'>";
         this.colorDic["%Cwh"] = "<font color = \'#22ff22\'>";
         this.colorDic["%Cmap"] = "<font color = \'#33CCFF\'>";
         this.colorDic["%Cor"] = "<font color = \'#fd5e00\'>";
      }
      
      private function initFuncDic() : void
      {
         this.funcDic = new Dictionary();
         this.funcDic["Fh"] = this.getRiverText;
         this.funcDic["Fn"] = this.getNameText;
         this.funcDic["Fe"] = this.getEquipText;
         this.funcDic["Fi"] = this.getItemText;
         this.funcDic["Ft"] = this.getTTFText;
         this.funcDic["Fx"] = this.getStarText;
         this.funcDic["Fv"] = this.getVipText;
         this.funcDic["Fr"] = this.getRankText;
         this.funcDic["Fm"] = this.getMeriText;
         this.funcDic["Fjf"] = this.getWHSoccerText;
         this.funcDic["Fmap"] = this.getMapNameText;
         this.funcDic["Fbn"] = this.getBangNameText;
         this.funcDic["Fjk"] = this.getJKText;
         this.funcDic["Fgn"] = this.getGrnName;
         this.funcDic["Fge"] = this.getGe;
         this.funcDic["Fls"] = this.getJJCComboWin;
         this.funcDic["Fqj"] = this.getQiJuName;
         this.funcDic["Fwb"] = this.getWabaoText;
         this.funcDic["Fmon"] = this.getMonsterName;
         this.funcDic["Fjx"] = this.getJXLevelTxt;
         this.funcDic["Fsb"] = this.getShenBingName;
         this.funcDic["Fxz"] = this.getXingZuoName;
         this.funcDic["Fhn"] = this.getHorseName;
         this.funcDic["Fcard"] = this.getCardName;
      }
      
      public function getMonsterName(sysID:int) : String
      {
         var npcInfo:Array = Data_lib.npc[sysID];
         return npcInfo != null ? npcInfo[Npc.NAME] : "niu bi id=:[" + sysID.toString() + "]";
      }
      
      public function getWabaoText(str:Object) : String
      {
         return str.toString();
      }
      
      public function getBitStr(value:int, bit:int = 2) : String
      {
         var tmp:String = value.toString();
         while(tmp.length < bit)
         {
            tmp = "0" + tmp;
         }
         return tmp;
      }
      
      public function getXingZuoName(xzID:int) : String
      {
         return "<font color=\'#00ff00\'>" + Data_lib.xingZuo[xzID][Enum_xingZuo.LIB_XZ_NAME] + "</font>";
      }
      
      public function getHorseName(hid:int) : String
      {
         return "<font color=\'#ff00ff\'>" + Data_lib.zqtj[hid][HorseConfig.LIB_HORSE_NAME] + "</font>";
      }
      
      public function getCardName(id:int) : String
      {
         return HtmlUtil.fontNoSize(Data_lib.card[id][2],ColorConstant.getItemColorStr(Data_lib.card[id][4]));
      }
      
      public function getColorStr(str:String, level:int = 1) : String
      {
         if(level == Enum_color.WHITE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.WHITE));
         }
         else if(level == Enum_color.GREEN)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.GREEN));
         }
         else if(level == Enum_color.BLUE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.BLUE));
         }
         else if(level == Enum_color.PURPLE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.PURPLE));
         }
         else if(level == Enum_color.ORANGE)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.ORANGE));
         }
         else if(level == Enum_color.ANJIN)
         {
            str = HtmlUtil.fontNoSize(str,ColorConstant.getColorStr(ColorConstant.ANJIN));
         }
         return str;
      }
      
      public function getMeriText(which:Object) : String
      {
         which as int;
         return "<font color = \'#ff0000\'>" + which.toString() + "</font>";
      }
      
      public function getRankText(rank:Object) : String
      {
         return LangConfig.getWord("28801",2,rank.toString());
      }
      
      public function getStarText(level:Object) : String
      {
         return LangConfig.getWord("28802",2,level.toString());
      }
      
      public function getEquipText(equipId:Object) : String
      {
         if(!Data_lib.equip[equipId])
         {
            return this.getItemText2(equipId);
         }
         return this.getColorStr(Data_lib.equip[equipId][Enum_lib_equip.STR_NAME],Data_lib.equip[equipId][Enum_lib_equip.COLOR]);
      }
      
      private function getItemText2(itemId:Object) : String
      {
         var str:String = null;
         try
         {
            str = this.getColorStr(Data_lib.item[itemId][Enum_lib_item.STR_NAME],Data_lib.item[itemId][Enum_lib_item.COLOR]);
         }
         catch(e:Error)
         {
            e.getStackTrace();
            throw new Error("non this type: id:" + itemId.toString());
         }
         return str;
      }
      
      public function getItemText(itemId:Object, size:int = 16) : String
      {
         if(Boolean(Data_lib.item[itemId]))
         {
            return this.getColorStr(Data_lib.item[itemId][Enum_lib_item.STR_NAME],Data_lib.item[itemId][Enum_lib_item.COLOR]);
         }
         return this.getEquipText2(itemId);
      }
      
      private function getEquipText2(equipId:Object) : String
      {
         var str:String = null;
         try
         {
            str = this.getColorStr(Data_lib.equip[equipId][Enum_lib_equip.STR_NAME],Data_lib.equip[equipId][Enum_lib_equip.COLOR]);
         }
         catch(e:Error)
         {
            e.getStackTrace();
            throw new Error("non this type: id:" + equipId.toString());
         }
         return str;
      }
      
      public function getJJCComboWin(times:Object) : String
      {
         return this.colorDic["%Cr"] + LangConfig.getWord("28816",2,times.toString());
      }
      
      public function getRiverText(riverId:Object) : String
      {
         if(riverId <= 36)
         {
            return LangConfig.getWord("28803",2,riverId);
         }
         return LangConfig.getWord("29417",2,int(riverId) - 36);
      }
      
      public function getBangNameText(str:Object) : String
      {
         return "【<font color = \'#ff00ff\'>" + Model_heFu.repNameUseSerID(str as String) + "</font>】";
      }
      
      public function getJKText(which:Object) : String
      {
         var id:int = 28810 + which;
         return "<font color = \'#ff00ff\'>" + LangConfig.getWord(id.toString(),2) + "</font>";
      }
      
      public function getGrnName(str:Object) : String
      {
         return "<font color=\'#33CCFF\'>" + Model_heFu.repNameByHero(str as String) + "</font>";
      }
      
      public function getGe(prm:Object) : String
      {
         return prm.toString();
      }
      
      public function getNameText(prm:Object) : String
      {
         var i:int = 0;
         var result:String = "";
         if(prm is Array)
         {
            i = 0;
            while(i < prm.length)
            {
               result += Model_heFu.repNameByHero(prm[i]) + " ";
               i++;
            }
         }
         else
         {
            result = Model_heFu.repNameStr(prm.toString());
         }
         return "<font color = \'#00ff00\'>" + result + "</font>";
      }
      
      public function getVipText(level:Object) : String
      {
         var itemId:int = 0;
         switch(level)
         {
            case 1:
               itemId = 46340;
               break;
            case 2:
               itemId = 46341;
               break;
            case 3:
               itemId = 46342;
         }
         return this.getItemText(itemId);
      }
      
      public function getTTFText(flood:Object) : String
      {
         var lv:int = int(flood);
         if(lv <= 100)
         {
            return LangConfig.getWord("28815",2,lv.toString());
         }
         if(lv < 2000 && lv >= 1000)
         {
            return LangConfig.reTxt("<font color=\'#ff0000\'>地狱通天峰{0}层</font>",lv % 1000);
         }
         if(lv > 2000)
         {
            return LangConfig.reTxt("<font color=\'#ff0000\'>地狱万安{0}层</font>",lv % 2000);
         }
         return LangConfig.getWord("28817",2,(lv - 100).toString());
      }
      
      public function getMapNameText(mapId:Object) : String
      {
         var mapStr:String = Data_lib.map[int(mapId)][0];
         return "<font color = \'#33CCFF\'>" + mapStr + "</font>";
      }
      
      public function getWHSoccerText(soccer:Object) : String
      {
         return "<font color = \'#00ff00\'>" + soccer.toString() + "</font>";
      }
      
      public function getQiJuName(lv:Object) : String
      {
         return this.getColorStr(Data_lib.zlchess[lv][0],lv as int);
      }
      
      public function getJXLevelTxt(lv:int) : String
      {
         return Data_lib.petjx[lv][0];
      }
      
      public function getShenBingName(id:int) : String
      {
         return this.getColorStr(Data_lib.sbSkill[id][Enum_ShenBing.SKILL_NAME],Data_lib.sbSkill[id][Enum_ShenBing.SKILL_QUALITY]);
      }
      
      public function replaceColor(str:String) : String
      {
         var key:String = null;
         var reg:RegExp = null;
         for(key in this.colorDic)
         {
            reg = new RegExp(key,"gi");
            str = str.replace(reg,this.colorDic[key]);
         }
         return "<font color = \'#00ff00\'>" + str + "</font>";
      }
      
      public function formToTimeString(__time:Number, __insertHout:String = " : ", __insertMinute:String = " : ") : String
      {
         var __hour:uint = uint(__time / 60 / 60 >> 0);
         var __minute:uint = __time / 60 % 60;
         var __second:uint = __time % 60;
         var __timeTxt:String = " ";
         __timeTxt += (__hour > 100 ? __hour.toString() : (100 + __hour).toString().substr(1)) + __insertHout;
         __timeTxt += (__minute < 10 ? "0" + __minute.toString() : __minute.toString()) + __insertMinute;
         return __timeTxt + (__second < 10 ? "0" + __second.toString() : __second.toString());
      }
      
      public function readLoopPatch(readTypeStr:String, ppatch:IDataInput) : Array
      {
         this.patch = ppatch;
         this.readTypeArr = readTypeStr.split("_");
         var node:Node = this.createNodes();
         return this.patchToArray(node);
      }
      
      private function patchToArray(node:Node) : Array
      {
         var result:Array = new Array();
         var len:int = node.numChild;
         var loc_int:int = 0;
         while(loc_int < len)
         {
            result.push(this.readChild(node.getChildAt(loc_int)));
            loc_int += 1;
         }
         return result;
      }
      
      private function readChild(node:Node) : Object
      {
         var result:Object = null;
         var loc_int:int = 0;
         var loc_int2:int = 0;
         var len:int = 0;
         if(node.type == "root")
         {
         }
         if(node.type == "loop")
         {
            result = new Array();
            len = this.readPatch(node.readType,this.patch) as int;
            loc_int = 0;
            while(loc_int < len)
            {
               loc_int2 = 0;
               while(loc_int2 < node.numChild)
               {
                  (result as Array).push(this.readChild(node.getChildAt(loc_int2)));
                  loc_int2 += 1;
               }
               loc_int += 1;
            }
         }
         else if(node.type == "read")
         {
            result = this.readPatch(node.readType,this.patch);
         }
         if(node.type == "root")
         {
         }
         return result;
      }
      
      private function createNodes() : Node
      {
         var root:Node = null;
         var loc_str:String = null;
         var newNode:Node = null;
         var nxtNode:Node = null;
         var curNode:Node = root = Node.getNode("root");
         var loc_int:int = 0;
         while(loc_int < this.readTypeArr.length)
         {
            loc_str = this.readTypeArr[loc_int];
            if(loc_str == "<l>")
            {
               newNode = Node.getNode("loop");
               loc_int += 1;
               newNode.readType = this.readTypeArr[loc_int];
               curNode.addChild(newNode);
               curNode = newNode;
            }
            else if(loc_str == "</l>")
            {
               curNode = curNode.parent;
            }
            else
            {
               nxtNode = Node.getNode("read");
               nxtNode.readType = this.readTypeArr[loc_int];
               curNode.addChild(nxtNode);
            }
            loc_int += 1;
         }
         return root;
      }
      
      public function patchToStr(msgId:int, ppatch:IDataInput) : String
      {
         var len:int = 0;
         var index:int = 0;
         var replaceText:String = null;
         var func:Function = null;
         var arr:Array = null;
         var obj:Object = null;
         this.patch = ppatch;
         var dataArr:Array = Data_lib.broadCast[msgId];
         var resultStr:String = dataArr[3] as String;
         if(dataArr[1] == undefined || dataArr[1] == 0)
         {
            return dataArr[3];
         }
         var reg:RegExp = /<l>/;
         this.readTypeArr = (dataArr[1] as String).split("_");
         this.funKeyArr = (dataArr[2] as String).split("_");
         if(reg.test(dataArr[1]))
         {
            arr = this.readLoopPatch(dataArr[1],ppatch);
            index = 0;
            while(index < arr.length)
            {
               func = this.funcDic[this.funKeyArr[index]];
               replaceText = func(arr[index]);
               resultStr = resultStr.replace("%Fun",replaceText);
               index++;
            }
            return resultStr;
         }
         len = int(this.readTypeArr.length);
         index = 0;
         while(index < len)
         {
            obj = this.readPatch(this.readTypeArr[index],this.patch);
            func = this.funcDic[this.funKeyArr[index]];
            replaceText = func(obj) as String;
            resultStr = resultStr.replace("%Fun",replaceText);
            index++;
         }
         this.readTypeArr = null;
         this.funKeyArr = null;
         this.patch = null;
         return resultStr;
      }
      
      private function readPatch(readType:String, patch:IDataInput) : Object
      {
         var obj:Object = null;
         switch(readType)
         {
            case "u":
               obj = patch.readUTF();
               break;
            case "b":
               obj = patch.readByte();
               break;
            case "s":
               obj = patch.readShort();
               break;
            case "i":
               obj = patch.readInt();
               break;
            default:
               throw new Error("not this type");
         }
         return obj;
      }
      
      private function init() : void
      {
         this.dic = new Dictionary();
         this.initColorDic();
         this.initFuncDic();
      }
   }
}

import flash.utils.Dictionary;

class Node
{
   
   private static var _pool:Dictionary = new Dictionary(true);
   
   private var _childrens:Vector.<Node>;
   
   private var _parent:Node;
   
   public var type:String;
   
   public var readType:String;
   
   public function Node(type:String)
   {
      super();
      this.type = type;
   }
   
   public static function getNode(type:String) : Node
   {
      var node:Node = null;
      var key:String = null;
      var _loc4_:int = 0;
      var _loc5_:* = _pool;
      for(key in _loc5_)
      {
         node = _pool[key];
         node.type = type;
         delete _pool[key];
      }
      if(!node)
      {
         node = new Node(type);
      }
      node.init();
      return node;
   }
   
   private function init() : void
   {
      this.type = this.type;
      this._childrens = new Vector.<Node>();
   }
   
   public function addChild(node:Node) : void
   {
      this._childrens.push(node);
      node._parent = this;
   }
   
   public function get parent() : Node
   {
      return this._parent;
   }
   
   public function get numChild() : int
   {
      return this._childrens.length;
   }
   
   public function dispose() : void
   {
      if(Boolean(this._childrens))
      {
         this._childrens.splice(0,this._childrens.length);
         this._childrens = null;
      }
      this.type = "";
      this.readType = "";
      this._parent = null;
      _pool[this] = this;
   }
   
   public function getChildAt(index:int) : Node
   {
      return this._childrens[index];
   }
   
   public function getChildIndex(node:Node) : int
   {
      return this._childrens.indexOf(node);
   }
}

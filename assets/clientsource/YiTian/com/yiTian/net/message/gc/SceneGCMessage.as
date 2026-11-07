package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.net.handler.SceneHandler;
   import com.yiTian.net.message.MessageType;
   import flash.utils.IDataInput;
   
   public class SceneGCMessage
   {
      
      private static var i_index:int = 0;
      
      private static var ii_index:int = 0;
      
      public function SceneGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_ENTER_SCENE] = this.GC_ENTER_SCENE;
         index[MessageType.GC_ENTER_FUBEN] = this.GC_ENTER_FUBEN;
         index[MessageType.GC_ADD_PLAYER] = this.GC_ADD_PLAYER;
         index[MessageType.GC_ADD_NPC] = this.GC_ADD_NPC;
         index[MessageType.GC_DEL_ROLE] = this.GC_DEL_ROLE;
         index[MessageType.GC_MOVE] = this.GC_MOVE;
         index[MessageType.GC_STOP_MOVE] = this.GC_STOP_MOVE;
         index[MessageType.GC_FUBEN_FINISH] = this.GC_FUBEN_FINISH;
         index[MessageType.GC_UPDATE_PLAYER] = this.GC_UPDATE_PLAYER;
         index[MessageType.GC_JUMP_POINT] = this.GC_JUMP_POINT;
         index[MessageType.GC_INBATTLE_STATUS] = this.GC_INBATTLE_STATUS;
         index[MessageType.GC_ADD_PET] = this.GC_ADD_PET;
         index[MessageType.GC_COLLECT] = this.GC_COLLECT;
         index[MessageType.GC_ENTER_FUBEN_FAULT] = this.GC_ENTER_FUBEN_FAULT;
         index[MessageType.GC_UPDATE_FUBENINFO] = this.GC_UPDATE_FUBENINFO;
         index[MessageType.GC_USE_SXF] = this.GC_USE_SXF;
         index[MessageType.GC_TEAM_WAIT] = this.GC_TEAM_WAIT;
         index[MessageType.GC_SET_SEND_USE_YB] = this.GC_SET_SEND_USE_YB;
      }
      
      public function GC_ENTER_SCENE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var sceneId:int = patch.readShort();
         var targetX:int = patch.readShort();
         var targetY:int = patch.readShort();
         SceneHandler.GC_ENTER_SCENE(result,sceneId,targetX,targetY);
      }
      
      public function GC_ENTER_FUBEN(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var sceneId:int = patch.readShort();
         var targetX:int = patch.readShort();
         var targetY:int = patch.readShort();
         SceneHandler.GC_ENTER_FUBEN(result,sceneId,targetX,targetY);
      }
      
      public function GC_ADD_PLAYER(patch:IDataInput) : void
      {
         var wulinChengHao:* = undefined;
         var array_Route:Array = null;
         var petInfo:Array = null;
         var result:int = patch.readByte();
         var status:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var globalX:int = patch.readShort();
         var globalY:int = patch.readShort();
         var speed:int = patch.readShort();
         var hp:int = patch.readInt();
         var hpMax:int = patch.readInt();
         var mp:int = patch.readInt();
         var mpMax:int = patch.readInt();
         var level:int = patch.readShort();
         var body:int = patch.readInt();
         var hair:int = patch.readInt();
         var weapon:int = patch.readInt();
         var horse:int = patch.readInt();
         var sex:int = patch.readByte();
         var job:int = patch.readByte();
         var direction:int = patch.readByte();
         var targetPos_len:int = patch.readShort();
         var targetPos:Array = [];
         i_index = 0;
         while(i_index < targetPos_len)
         {
            array_Route = [];
            array_Route.push(patch.readShort());
            array_Route.push(patch.readShort());
            targetPos.push(array_Route);
            ++i_index;
         }
         var captainId:Number = LongUtil.readLong(patch);
         var teamPosition:int = patch.readByte();
         var pets:Array = [];
         var pet_len:int = patch.readByte();
         i_index = 0;
         while(i_index < pet_len)
         {
            petInfo = [];
            petInfo.push(LongUtil.readLong(patch));
            petInfo.push(patch.readUTF());
            petInfo.push(patch.readInt());
            petInfo.push(patch.readInt());
            petInfo.push(patch.readInt());
            petInfo.push(patch.readInt());
            petInfo.push(patch.readInt());
            petInfo.push(patch.readShort());
            petInfo.push(patch.readByte());
            petInfo.push(patch.readByte());
            petInfo.push(patch.readByte());
            petInfo.push(patch.readByte());
            petInfo.push(patch.readByte());
            pets.push(petInfo);
            ++i_index;
         }
         var vip:int = patch.readByte();
         var partyId:Number = LongUtil.readLong(patch);
         var party:String = Model_heFu.repNameByHero(patch.readUTF());
         var battleTime:int = patch.readInt();
         var paoBiao:int = patch.readByte();
         var chengHao:int = patch.readByte();
         wulinChengHao = patch.readUTF();
         var YLDiaLvl:int = patch.readByte();
         var isYearDia:int = patch.readByte();
         var huangZuanLvl:int = patch.readByte();
         var isHuangZuanYear:int = patch.readByte();
         var huiYuan:int = patch.readByte();
         var huiYuanYear:int = patch.readByte();
         var superLan:int = patch.readByte();
         var superLanYear:int = patch.readByte();
         var xinYueType:int = patch.readByte();
         var xinLvl:int = patch.readByte();
         var isShow:int = patch.readByte();
         var xunZhangLvl:int = patch.readByte();
         var isSuperHuang:int = 0;
         if(LZBmp.isUsingSuperHuangZuan)
         {
            isSuperHuang = patch.readByte();
         }
         var partner:Number = LongUtil.readLong(patch);
         var skillStr:String = patch.readUTF();
         var shenBing:int = patch.readByte();
         var zoneId:int = patch.readInt();
         var wingId:int = Boolean(patch.bytesAvailable) ? patch.readInt() : 0;
         SceneHandler.GC_ADD_PLAYER(result,status,id,name,globalX,globalY,speed,hp,hpMax,mp,mpMax,level,body,hair,weapon,horse,sex,job,direction,targetPos,captainId,teamPosition,pets,vip,partyId,party,battleTime,paoBiao,chengHao,wulinChengHao,YLDiaLvl,isYearDia,huangZuanLvl,isHuangZuanYear,huiYuan,huiYuanYear,superLan,superLanYear,xinYueType,xinLvl,isShow,xunZhangLvl,isSuperHuang,partner,skillStr,shenBing,zoneId,wingId);
      }
      
      public function GC_UPDATE_PLAYER(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var captainId:Number = LongUtil.readLong(patch);
         var teamPosition:int = patch.readByte();
         var speed:int = patch.readShort();
         SceneHandler.GC_UPDATE_PLAYER(id,captainId,teamPosition,speed);
      }
      
      public function GC_DEL_ROLE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:Number = LongUtil.readLong(patch);
         var type:int = patch.readByte();
         SceneHandler.GC_DEL_ROLE(result,id,type);
      }
      
      public function GC_MOVE(patch:IDataInput) : void
      {
         var array_Route:Array = null;
         var id:Number = LongUtil.readLong(patch);
         var type:int = patch.readByte();
         var route_len:int = patch.readShort();
         var route:Array = [];
         i_index = 0;
         while(i_index < route_len)
         {
            array_Route = [];
            array_Route.push(patch.readShort());
            array_Route.push(patch.readShort());
            route.push(array_Route);
            ++i_index;
         }
         SceneHandler.GC_MOVE(id,type,route);
      }
      
      public function GC_STOP_MOVE(patch:IDataInput) : void
      {
         var id:Number = LongUtil.readLong(patch);
         var posX:int = patch.readShort();
         var posY:int = patch.readShort();
         SceneHandler.GC_STOP_MOVE(id,posX,posY);
      }
      
      public function GC_ADD_NPC(patch:IDataInput) : void
      {
         var array_Route:Array = null;
         var objId:Number = LongUtil.readLong(patch);
         var sysId:int = patch.readInt();
         var globalX:int = patch.readShort();
         var globalY:int = patch.readShort();
         var hp:int = patch.readInt();
         var hpMax:int = patch.readInt();
         var mp:int = patch.readInt();
         var mpMax:int = patch.readInt();
         var direction:int = patch.readByte();
         var route_len:int = patch.readShort();
         var route:Array = [];
         i_index = 0;
         while(i_index < route_len)
         {
            array_Route = [];
            array_Route.push(patch.readShort());
            array_Route.push(patch.readShort());
            route.push(array_Route);
            ++i_index;
         }
         var buffer_len:int = patch.readShort();
         var buffer:Array = [];
         i_index = 0;
         while(i_index < buffer_len)
         {
            buffer.push(patch.readInt());
            ++i_index;
         }
         SceneHandler.GC_ADD_NPC(objId,sysId,globalX,globalY,hp,hpMax,mp,mpMax,direction,route,buffer);
      }
      
      public function GC_FUBEN_FINISH(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         SceneHandler.GC_FUBEN_FINISH(result);
      }
      
      public function GC_JUMP_POINT(patch:IDataInput) : void
      {
         var roldId:Number = LongUtil.readLong(patch);
         var sceneId:int = patch.readShort();
         var sceneType:int = patch.readByte();
         var posX:int = patch.readInt();
         var posY:int = patch.readInt();
         var way:int = patch.readByte();
         SceneHandler.GC_JUMP_POINT(roldId,sceneId,sceneType,posX,posY,way);
      }
      
      public function GC_INBATTLE_STATUS(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         var roleId:Number = LongUtil.readLong(patch);
         var leftTime:int = patch.readShort();
         SceneHandler.GC_INBATTLE_STATUS(roleId,type,leftTime);
      }
      
      public function GC_ADD_PET(patch:IDataInput) : void
      {
         var heroId:Number = LongUtil.readLong(patch);
         var petid:Number = LongUtil.readLong(patch);
         var name:String = patch.readUTF();
         var body1:int = patch.readInt();
         var body2:int = patch.readInt();
         var body3:int = patch.readInt();
         var speed:int = patch.readShort();
         var hp:int = patch.readInt();
         var hpMax:int = patch.readInt();
         var level:int = patch.readShort();
         var zhizi:int = patch.readByte();
         var chengzang:int = patch.readByte();
         var hxjx:int = patch.readByte();
         var petType:int = patch.readByte();
         var tupo:int = patch.readByte();
         SceneHandler.GC_ADD_PET(heroId,petid,name,body1,body2,body3,speed,hp,hpMax,level,zhizi,chengzang,hxjx,petType,tupo);
      }
      
      public function GC_COLLECT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         SceneHandler.GC_COLLECT(result);
      }
      
      public function GC_ENTER_FUBEN_FAULT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         SceneHandler.GC_ENTER_FUBEN_FAULT(result);
      }
      
      public function GC_UPDATE_FUBENINFO(patch:IDataInput) : void
      {
         var sceneId:int = patch.readInt();
         var fubenId:int = patch.readInt();
         SceneHandler.GC_UPDATE_FUBENINFO(sceneId,fubenId);
      }
      
      public function GC_USE_SXF(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         SceneHandler.GC_USE_SXF(result);
      }
      
      public function GC_SET_SEND_USE_YB(patch:IDataInput) : void
      {
         SceneHandler.GC_SET_SEND_USE_YB();
      }
      
      public function GC_TEAM_WAIT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         SceneHandler.GC_TEAM_WAIT(result);
      }
   }
}


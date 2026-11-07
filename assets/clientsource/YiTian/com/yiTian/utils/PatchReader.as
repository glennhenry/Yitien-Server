package com.yiTian.utils
{
   import com.utils.LongUtil;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.utils.IDataInput;
   
   public class PatchReader
   {
      
      private static var _ins:PatchReader;
      
      public function PatchReader()
      {
         super();
      }
      
      public static function get instance() : PatchReader
      {
         if(!_ins)
         {
            _ins = new PatchReader();
         }
         return _ins;
      }
      
      public function readPatch(readTypes:Array, patch:IDataInput) : Array
      {
         var len:int = int(readTypes.length);
         var result:Array = [];
         var i:int = 0;
         while(i < len)
         {
            result.push(this.invoke(readTypes[i],patch));
            i += 1;
         }
         return result;
      }
      
      private function invoke(readTypes:Object, patch:IDataInput) : Object
      {
         var result:Object = null;
         var head:String = null;
         var numChar:int = 0;
         if(readTypes is String)
         {
            result = this.read(readTypes as String,patch);
         }
         else
         {
            head = readTypes[0];
            result = [];
            numChar = int((readTypes as Array).length);
            if(head == "+")
            {
               this.read_add(readTypes,patch,result as Array);
            }
            else
            {
               this.read_def(readTypes,patch,result as Array);
            }
         }
         return result;
      }
      
      private function read_add(readTypes:Object, patch:IDataInput, disArr:Array) : void
      {
         var ii_index:int = 0;
         var numChar:int = int((readTypes as Array).length);
         var numLoop:int = this.read(readTypes[1],patch) as int;
         var i_index:int = 0;
         while(i_index < numLoop)
         {
            ii_index = 2;
            while(ii_index < numChar)
            {
               disArr.push(this.invoke(readTypes[ii_index],patch));
               ii_index += 1;
            }
            i_index += 1;
         }
      }
      
      private function read_def(readTypes:Object, patch:IDataInput, disArr:Array) : void
      {
         var i_index:int = 0;
         var tmp:Array = null;
         var ii_index:int = 0;
         var numLoop:int = this.read(readTypes[0],patch) as int;
         var numChar:int = int((readTypes as Array).length);
         while(i_index < numLoop)
         {
            tmp = [];
            ii_index = 1;
            while(ii_index < numChar)
            {
               tmp.push(this.invoke(readTypes[ii_index],patch));
               ii_index += 1;
            }
            disArr.push(tmp);
            i_index += 1;
         }
      }
      
      public function read(type:String, patch:IDataInput) : Object
      {
         var result:Object = null;
         switch(type)
         {
            case "b":
               result = patch.readByte();
               break;
            case "s":
               result = patch.readShort();
               break;
            case "i":
               result = patch.readInt();
               break;
            case "u":
               result = patch.readUTF();
               break;
            case "l":
               result = LongUtil.readLong(patch);
               break;
            default:
               Utils.print("error type:" + type);
         }
         return result;
      }
      
      public function readGeneralPatch(patch:IDataInput) : Array
      {
         var curType:int = 0;
         var result:Array = [];
         while(patch.bytesAvailable > 0)
         {
            curType = patch.readByte();
            result.push(this.read2(curType,patch));
         }
         return result;
      }
      
      public function read2(type:int, patch:IDataInput) : Object
      {
         var result:Object = null;
         switch(type)
         {
            case 1:
               result = patch.readByte();
               break;
            case 2:
               result = patch.readShort();
               break;
            case 3:
               result = patch.readInt();
               break;
            case 4:
               result = patch.readUTF();
               break;
            default:
               Utils.print("error type:" + type);
         }
         return result;
      }
      
      public function readBattle(patch:IDataInput) : Array
      {
         var hitTimes:int = 0;
         var hitTimesIndex:int = 0;
         var hurtSteps:Array = null;
         var hurtStep:Array = null;
         var array_ROLE_INFO:Array = null;
         var numStep:int = 0;
         var step:int = 0;
         var roundStartData:Array = null;
         var stepIndex:int = 0;
         var numRole:int = 0;
         var roleIndex:int = 0;
         var flag:int = 0;
         var roundStartRoldId:Number = NaN;
         var sbId:int = 0;
         var value:int = 0;
         var maxValue:int = 0;
         var launcherId:Number = NaN;
         var array_WAR_STEP:Array = null;
         var roleId:Number = NaN;
         var temp_bufferId_len:int = 0;
         var temp_bufferId:Array = null;
         var temp_array_targets_len:int = 0;
         var temp_array_targets:Array = null;
         var tempBufID:int = 0;
         var tempLaunchID:Number = NaN;
         var temp_TARGET:Array = null;
         var buf_len:int = 0;
         var buf:Array = null;
         var iii_index:int = 0;
         var targets_len:int = 0;
         var targets:Array = null;
         var bufID:int = 0;
         var bufLaunchID:Number = NaN;
         var TARGET:Array = null;
         var buf_len2:int = 0;
         var buf2:Array = null;
         var iiii_index:int = 0;
         var buf2ID:int = 0;
         var buf2LaunchID:Number = NaN;
         var i_index:int = 0;
         var ii_index:int = 0;
         var battleId:int = patch.readInt();
         var resultFlag:int = patch.readByte();
         var result:int = resultFlag & 1;
         var isReadRoundStart:int = resultFlag & 0x10;
         var isReadBufLaunchID:int = resultFlag & 0x20;
         var isUseHitArr:int = resultFlag & 0x40;
         var type:int = patch.readByte();
         var selfZF:int = patch.readInt();
         var targetZF:int = patch.readInt();
         var roles_len:int = patch.readShort();
         var roles:Array = [];
         i_index = 0;
         while(i_index < roles_len)
         {
            array_ROLE_INFO = [];
            array_ROLE_INFO.push(type == 50 ? patch.readInt() : LongUtil.readLong(patch));
            array_ROLE_INFO.push(patch.readByte());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readByte());
            array_ROLE_INFO.push(patch.readByte());
            array_ROLE_INFO.push(patch.readUTF());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readByte());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readByte());
            array_ROLE_INFO.push(patch.readByte());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(patch.readInt());
            array_ROLE_INFO.push(0);
            roles.push(array_ROLE_INFO);
            i_index++;
         }
         var steps:Array = [];
         var steps_len:int = patch.readShort();
         var roundStartMap:Object = {};
         if(isReadRoundStart == 16)
         {
            numStep = patch.readByte();
            step = 0;
            while(step < numStep)
            {
               roundStartData = [];
               stepIndex = patch.readByte();
               numRole = patch.readByte();
               roleIndex = 0;
               while(roleIndex < numRole)
               {
                  flag = patch.readByte();
                  roundStartRoldId = LongUtil.readLong(patch);
                  sbId = patch.readInt();
                  value = patch.readInt();
                  maxValue = patch.readInt();
                  launcherId = Boolean(isReadBufLaunchID) ? LongUtil.readLong(patch) : 0;
                  roundStartData.push([flag,roundStartRoldId,sbId,value,maxValue,launcherId]);
                  roleIndex += 1;
               }
               roundStartMap[stepIndex] = roundStartData;
               step += 1;
            }
         }
         i_index = 0;
         while(i_index < steps_len)
         {
            array_WAR_STEP = [];
            array_WAR_STEP.push(patch.readShort());
            roleId = type == 50 ? patch.readInt() : LongUtil.readLong(patch);
            array_WAR_STEP.push(roleId);
            array_WAR_STEP.push(patch.readInt());
            array_WAR_STEP.push(patch.readInt());
            array_WAR_STEP.push(patch.readInt());
            array_WAR_STEP.push(patch.readInt());
            array_WAR_STEP.push(patch.readInt());
            temp_bufferId_len = patch.readShort();
            temp_bufferId = [];
            ii_index = 0;
            while(ii_index < temp_bufferId_len)
            {
               tempBufID = patch.readInt();
               tempLaunchID = isReadBufLaunchID != 0 ? LongUtil.readLong(patch) : 0;
               temp_bufferId.push([tempBufID,tempLaunchID]);
               ii_index++;
            }
            array_WAR_STEP.push(temp_bufferId);
            temp_array_targets_len = patch.readShort();
            temp_array_targets = [];
            ii_index = 0;
            while(ii_index < temp_array_targets_len)
            {
               temp_TARGET = [];
               temp_TARGET.push(type == 50 ? patch.readInt() : LongUtil.readLong(patch));
               if(isUseHitArr == 0)
               {
                  hitTimes = 0;
               }
               else
               {
                  hitTimes = patch.readShort();
               }
               hurtSteps = [];
               hitTimesIndex = 0;
               while(hitTimesIndex < hitTimes)
               {
                  hurtStep = [];
                  hurtStep.push(patch.readInt());
                  hurtStep.push(patch.readInt());
                  hurtStep.push(patch.readInt());
                  hurtStep.push(patch.readInt());
                  if(hitTimesIndex != 0)
                  {
                     hurtStep.push(2);
                  }
                  hurtSteps.push(hurtStep);
                  hitTimesIndex++;
               }
               hurtStep = [];
               hurtStep.push(patch.readInt());
               hurtStep.push(patch.readInt());
               hurtStep.push(patch.readInt());
               hurtStep.push(patch.readInt());
               hurtStep.push(2);
               hurtSteps.push(hurtStep);
               temp_TARGET.push(hurtSteps,hurtSteps,hurtSteps,hurtSteps);
               buf_len = patch.readShort();
               buf = [];
               iii_index = 0;
               while(iii_index < buf_len)
               {
                  bufID = patch.readInt();
                  bufLaunchID = isReadBufLaunchID != 0 ? LongUtil.readLong(patch) : 0;
                  buf.push([bufID,bufLaunchID]);
                  iii_index++;
               }
               trace(buf);
               temp_TARGET.push(buf);
               temp_TARGET.push(patch.readByte());
               temp_TARGET.push(patch.readByte());
               temp_TARGET.push(patch.readInt());
               targets_len = patch.readShort();
               targets = [];
               iii_index = 0;
               while(iii_index < targets_len)
               {
                  TARGET = [];
                  TARGET.push(type == 50 ? patch.readInt() : LongUtil.readLong(patch));
                  TARGET.push(patch.readInt());
                  TARGET.push(patch.readInt());
                  TARGET.push(patch.readInt());
                  TARGET.push(patch.readInt());
                  buf_len2 = patch.readShort();
                  buf2 = [];
                  iiii_index = 0;
                  while(iiii_index < buf_len2)
                  {
                     buf2ID = patch.readInt();
                     buf2LaunchID = isReadBufLaunchID != 0 ? LongUtil.readLong(patch) : 0;
                     buf2.push([buf2ID,buf2LaunchID]);
                     iiii_index++;
                  }
                  TARGET.push(buf2);
                  TARGET.push(patch.readByte());
                  TARGET.push(patch.readByte());
                  targets.push(TARGET);
                  iii_index++;
               }
               temp_TARGET.push(targets);
               temp_array_targets.push(temp_TARGET);
               ii_index++;
            }
            array_WAR_STEP.push(temp_array_targets);
            array_WAR_STEP.push(patch.readByte());
            steps.push(array_WAR_STEP);
            i_index++;
         }
         var babySkill:String = "0_0";
         if(HuaShanUtil.isReadBattleDataOfBabySkill)
         {
            babySkill = patch.readUTF();
         }
         var isWin:int = patch.readByte();
         return [battleId,result,type,selfZF,targetZF,roles,steps,isWin,roundStartMap,babySkill];
      }
   }
}


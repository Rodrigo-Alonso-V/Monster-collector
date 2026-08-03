import { Injectable, NotFoundException } from "@nestjs/common";
import { Model, Types } from "mongoose";
import { InjectModel } from "@nestjs/mongoose";
import { Monster } from "./schemas/monster.schema";
import { error } from "console";


@Injectable()
export class MonsterService {
    constructor(@InjectModel(Monster.name) private monsterModel: Model<Monster>) {}

    async getAllMonsters() {
        return this.monsterModel.find().exec()
    }

    async getMonstersByUserId(idUser: string) {
        return this.monsterModel.find({owner: new Types.ObjectId(idUser)})
    }

    async getPropertiesMonster(idMonster: string) {
        return this.monsterModel.find({_id: new Types.ObjectId(idMonster)})
    }

    async getMonsterByName(idUser: string, newText:string) {
        return await this.monsterModel.find({owner: new Types.ObjectId(idUser), name: {$regex: '^' + (newText || ''), $options: 'i'}})
    }

    async getMonsterByLevelAndName(idUser: string, newText: string) {
        return await this.monsterModel.find({owner: new Types.ObjectId(idUser),name: { $regex: '^' + (newText || ''), $options: 'i' }}).sort({ level: -1 }); // -1 ordena de mayor a menor (descendente)
}
    
    async postMonsterInUser(idUser: string, nameMonster: string) {
        this.monsterModel.insertOne({name: nameMonster, owner: new Types.ObjectId(idUser)})
    }

    async patchLevelMonster(idMonster: string, newLevel: number) {
        await this.monsterModel.updateOne({_id: new Types.ObjectId(idMonster)}, {$set: {level: newLevel}})
        return this.monsterModel.findOne({_id: idMonster})
    }

    async deleteMonster(idMonster: string) {
        return await this.monsterModel.deleteOne({_id: idMonster})
    }
    
}
import { Injectable } from "@nestjs/common";
import { Model } from "mongoose";
import { InjectModel } from "@nestjs/mongoose";
import { User, userSchema } from "./schema/user.schema";
import { pass } from "three/tsl";


@Injectable()
export class UserService {
    constructor(@InjectModel(User.name) private userModel: Model<User>) {}

    async getAllUsers() {
        return this.userModel.find().exec()
    }

    async getValidateUser(username: string) {
        if(await this.userModel.findOne({username: username})) {
            return true
        } else{
            return false
        }
    }

    async getMyId(username: string ) {
        return this.userModel.findOne({username: username}).select("_id")
    }

    

    async postCreateUser(username: string) {
        this.userModel.insertOne({username: username})
    }

}
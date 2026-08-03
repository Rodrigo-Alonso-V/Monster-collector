import { Module } from "@nestjs/common";
import { MonsterController } from "./monster.controller";
import { MonsterService } from "./monster.service";
import { MongooseModule } from "@nestjs/mongoose";
import { Monster, monsterSchema } from "./schemas/monster.schema";


@Module({
    imports: [MongooseModule.forFeature([{name: Monster.name, schema: monsterSchema}])],
    controllers: [MonsterController],
    providers: [MonsterService]
})
export class MonsterModule {}
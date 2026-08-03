import { Controller, Delete, Get, Param, ParseIntPipe, Patch, Post, Query} from "@nestjs/common";
import { MonsterService } from "./monster.service";
import { console } from "inspector";


@Controller('monsters')
export class MonsterController {
    constructor(private readonly monsterService: MonsterService) {}

    @Get('all')
    getAllMonsters() {
        return this.monsterService.getAllMonsters()
    }

    @Get('monstersById/:idUser')
    getMonstersByUser(@Param('idUser') idUser:string) {
        return this.monsterService.getMonstersByUserId(idUser)
    }

    @Get('properties/:idMonster')
    getPropertiesMonster(@Param("idMonster") idMonster: string) {
        return this.monsterService.getPropertiesMonster(idMonster)
    }

    @Get('searchByName/:idUser')
    getMonsterByName(@Param("idUser") idUser: string, @Query("newText") newText: string) {
        return this.monsterService.getMonsterByName(idUser, newText || '')
    }

    @Get('searchByLevelName/:idUser')
    getMonsterByLevelName(@Param('idUser') idUser: string, @Query('newText') newText: string) {
        return this.monsterService.getMonsterByLevelAndName(idUser, newText || '');
}
    
    @Post('insert/:idUser/:nameMonster')
    postMonsterInUser(@Param('idUser') idUser: string, @Param('nameMonster') nameMonster: string) {
        return this.monsterService.postMonsterInUser(idUser,nameMonster)
    }

    @Patch('update/:idMonster/:newLevel')
    patchLevelMonster(@Param("idMonster") idMonster: string, @Param("newLevel", ParseIntPipe) newLevel: number) {
        return this.monsterService.patchLevelMonster(idMonster, newLevel)
    }

    @Delete('deleteMonster/:idMonster')
    deleteMonster(@Param("idMonster") idMonster: string) {
        return this.monsterService.deleteMonster(idMonster)
    }
}
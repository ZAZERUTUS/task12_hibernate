package org.example.controller;

import org.example.model.House;
import org.example.service.HouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api")
public class HouseController {

    @Autowired
    private HouseService houseService;

    @GetMapping("/houses")
    public Page<House> getAllHouses(@RequestParam(defaultValue = "0") int page,
                                    @RequestParam(defaultValue = "15") int size) {
        return houseService.getAllHouses(PageRequest.of(page, size));
    }

    @GetMapping("/houses/{houseId}")
    public House getHouseById(@PathVariable Long houseId) {
        return houseService.getHouseById(houseId);
    }

    @PostMapping("/houses")
    public House createHouse(@RequestBody House house) {
        return houseService.createHouse(house);
    }

    @PutMapping("/houses/{houseId}")
    public House updateHouse(@PathVariable Long houseId, @RequestBody House updatedHouse) {
        return houseService.updateHouse(houseId, updatedHouse);
    }

    @DeleteMapping("/houses/{houseId}")
    public void deleteHouse(@PathVariable Long houseId) {
        houseService.deleteHouse(houseId);
    }
}

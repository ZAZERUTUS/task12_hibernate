package org.example.service;

import org.example.model.House;
import org.example.model.Person;
import org.example.repository.HouseRepository;
import org.example.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.ArrayList;
import java.util.List;

@Service
public class HouseService {

    @Autowired
    private HouseRepository houseRepository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private PersonRepository personRepository;

    public Page<House> getAllHouses(Pageable pageable) {
        return houseRepository.findAll(pageable);
    }

    public House getHouseById(Long houseId) {
        return houseRepository.findById(houseId)
                .orElseThrow(() -> new EntityNotFoundException("House not found with id: " + houseId));
    }

    public House createHouse(House house) {
        return houseRepository.save(house);
    }

    public House updateHouse(Long houseId, House updatedHouse) {
        House existingHouse = getHouseById(houseId);
        existingHouse.setArea(updatedHouse.getArea());
        existingHouse.setCountry(updatedHouse.getCountry());

        return houseRepository.save(existingHouse);
    }

    public void deleteHouse(Long houseId) {
        houseRepository.deleteById(houseId);
    }



    public List<House> getHousesByOwner(Person owner) {
        return houseRepository.findByOwnersContains(owner);
    }


    public List<Person> getResidentsByHouseId(Long houseId) {
        House house = houseRepository.findById(houseId)
                .orElseThrow(() -> new RuntimeException("House not found with id " + houseId));
        return new ArrayList<>(house.getResidents());
    }

    public List<House> getOwnedHousesByPersonId(Long personId) {
        Person person = personRepository.findById(personId)
                .orElseThrow(() -> new RuntimeException("Person not found with id " + personId));
        return houseRepository.findByOwnersContains(person);
    }
}


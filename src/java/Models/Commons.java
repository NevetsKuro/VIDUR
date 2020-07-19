/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.util.List;

/**
 *
 * @author Nevets
 */
public class Commons {
    List<String> technicians;
    List<String> machineIds;
    List<String> durgs;

    public List<String> getTechnicians() {
        return technicians;
    }

    public void setTechnicians(List<String> technicians) {
        this.technicians = technicians;
    }

    public List<String> getMachineIds() {
        return machineIds;
    }

    public void setMachineIds(List<String> machineIds) {
        this.machineIds = machineIds;
    }

    public List<String> getDurgs() {
        return durgs;
    }

    public void setDurgs(List<String> durgs) {
        this.durgs = durgs;
    }

    
    
}

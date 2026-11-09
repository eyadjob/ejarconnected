package automation.framework.ApiAutomation;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import automation.framework.business.StringHelper;

public class VehicleOperationsApi {

    // ---------- endpoint (relative to api.base.url) ----------
    private static final String CREATE_VEHICLES = "api/services/app/Vehicle/CreateVehicles";

    // ---------- fixed values from your JMeter request ----------
    private static final String ODOMETER = "22";
    private static final int FUEL_ID = 208;
    private static final String COUNTRY_ID = "1";
    private static final String MODEL_ID = "2797";
    private static final int YEAR = 2020;
    private static final String LICENSE_TYPE_ID = "181";
    private static final String USAGE_TYPE_ID = "190";
    private static final String INSURANCE_COMPANY_ID = "79e51573-da85-4737-b3a3-92d0a3860353";
    private static final int ACCIDENT_POLICY_ID = 52;
    private static final String CURRENT_LOCATION_ID = "401";
    private static final String VENDOR_ID = "79e51573-da85-4737-b3a3-92d0a3860353";
    private static final String PRICE = "35000";
    private static final String COLOR_ID = "1001706";
    private static final String TRIM_LEVEL_ID = "1001707";
    private static final String FUEL_TYPE_ID = "16";
    private static final int FUEL_TANK_SIZE = 60;
    private static final int ENGINE_SIZE = 1500;

    private static final DateTimeFormatter DATE_TIME = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // ---------- request: every JSON key of CreateVehicles ----------
    public record CreateVehiclesRequest(List<VehicleDto> vehicleDtos) {
    }

    public record VehicleDto(
            Boolean isBulkUploaded,
            String odometer,
            int fuelId,
            String branchId,
            VehicleManufacturingInfo vehicleManufacturingInfo,
            VehicleLicenseInfo vehicleLicenseInfo,
            VehicleInsuranceInfo vehicleInsuranceInfo,
            LocationInfo locationInfo,
            PurchaseInfo purchaseInfo,
            Specs specs,
            String countryId) {
    }

    public record VehicleManufacturingInfo(String modelId, int year, String chassisNo) {
    }

    public record VehicleLicenseInfo(String licenseTypeId, String usageTypeId, String plateNo) {
    }

    public record VehicleInsuranceInfo(String expiryDate, String number,
                                       String insuranceCompanyId, int accidentPolicyId) {
    }

    public record LocationInfo(String currentLocationId) {
    }

    public record PurchaseInfo(String vendorId, String date, String price) {
    }

    public record Specs(String colorId, String trimLevelId, String fuelTypeId,
                        int fuelTankSize, int engineSize) {
    }

    // ---------- the vehicle we created (the API returns no id, so these are the values we sent) ----------
    public record Vehicle(String plateNo, String chassisNo, String branchId,
                          String modelId, int year, String rawResponse) {
    }

    // ---------- the API call ----------
    public static Vehicle createVehicleWithRandomData() {
        String branchId = GetOperationsApis.getBranchId("Automation Branch");
        String plateNo = StringHelper.getRandomPlateNumber("saudi");
        String chassisNo = StringHelper.getRandomNumberOfSize(17);
        String insuranceNumber = StringHelper.getRandomNumberOfSize(10);

        VehicleDto dto = new VehicleDto(
                null,
                ODOMETER,
                FUEL_ID,
                branchId,
                new VehicleManufacturingInfo(MODEL_ID, YEAR, chassisNo),
                new VehicleLicenseInfo(LICENSE_TYPE_ID, USAGE_TYPE_ID, plateNo),
                new VehicleInsuranceInfo(LocalDateTime.now().plusYears(1).format(DATE_TIME),
                        insuranceNumber, INSURANCE_COMPANY_ID, ACCIDENT_POLICY_ID),
                new LocationInfo(CURRENT_LOCATION_ID),
                new PurchaseInfo(VENDOR_ID, LocalDateTime.now().minusDays(1).format(DATE_TIME), PRICE),
                new Specs(COLOR_ID, TRIM_LEVEL_ID, FUEL_TYPE_ID, FUEL_TANK_SIZE, ENGINE_SIZE),
                COUNTRY_ID);

        List<VehicleDto> dtos = new ArrayList<>();
        dtos.add(dto);

        ApiClient.post(CREATE_VEHICLES, new CreateVehiclesRequest(dtos));
        if (ApiClient.lastStatus() != 200) {
            throw new AssertionError(
                    "Create Vehicle API failed! Expected status: 200"
                            + ", Actual status: " + ApiClient.lastStatus()
                            + ", Response: " + ApiClient.lastBody()
            );
        }
        System.out.println("CreateVehicles status: " + ApiClient.lastStatus());

        Vehicle vehicle = new Vehicle(plateNo, chassisNo, branchId, MODEL_ID, YEAR, ApiClient.lastBody());
        ApiClient.store("vehicle", vehicle);
        System.out.println("Vehicle created through API Plate NO: " + vehicle.plateNo);
        return vehicle;
    }
}

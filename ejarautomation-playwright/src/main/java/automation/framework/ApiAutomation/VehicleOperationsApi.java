package automation.framework.ApiAutomation;

import automation.framework.ApiAutomation.beans.VehicleRequestRecord.*;
import automation.framework.ApiAutomation.beans.VehicleRequestRecord.VehicleDto.*;
import automation.framework.ApiAutomation.beans.VehicleResponseRecord;
import automation.framework.ApiAutomation.beans.VehicleResponseRecord.Vehicle;
import automation.framework.business.StringHelper;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class VehicleOperationsApi {

    // ---------- fixed values from your JMeter request ----------
    public static final String BRANCH_NAME = "Automation Branch";
    public static final String ODOMETER = "22";
    public static final int FUEL_ID = 208;
    public static final String COUNTRY_ID = "1";
    public static final String MODEL_ID = "2797";
    public static final int YEAR = 2020;
    public static final String LICENSE_TYPE_ID = "181";
    public static final String USAGE_TYPE_ID = "190";
    public static final String INSURANCE_COMPANY_ID = "79e51573-da85-4737-b3a3-92d0a3860353";
    public static final int ACCIDENT_POLICY_ID = 52;
    public static final String CURRENT_LOCATION_ID = "401";
    public static final String VENDOR_ID = "79e51573-da85-4737-b3a3-92d0a3860353";
    public static final String PRICE = "35000";
    public static final String COLOR_ID = "1001706";
    public static final String TRIM_LEVEL_ID = "1001707";
    public static final String FUEL_TYPE_ID = "16";
    public static final int FUEL_TANK_SIZE = 60;
    public static final int ENGINE_SIZE = 1500;

    public static final DateTimeFormatter DATE_TIME = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public final ApiClient apiClient;
    public final AuthenticationOperationsApi authenticationApi;
    public final GetOperationsApis getApis;

    public VehicleOperationsApi(ApiClient apiClient) {
        this.apiClient = apiClient;
        this.authenticationApi = new AuthenticationOperationsApi(apiClient);
        this.getApis = new GetOperationsApis(apiClient);
    }

    public Vehicle createVehicleWithRandomData() {
        authenticationApi.ensureLoggedIn();

        String branchId = getApis.getBranchId(BRANCH_NAME);
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

        apiClient.post(
                ApiUris.CREATE_VEHICLES_URI,
                new CreateVehicleRequest(new VehicleDto[]{dto})
        );

        apiClient.assertStatusCode(2000,ApiUris.CREATE_VEHICLES_URI);

        apiClient.assertApiSuccess();

        Vehicle vehicle = new Vehicle(plateNo, chassisNo, branchId, MODEL_ID, YEAR, apiClient.lastBody());
        apiClient.store("vehicle", vehicle);
        System.out.println("Vehicle created through API Plate NO: " + vehicle.plateNo());
        return vehicle;
    }
}
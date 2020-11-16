import React from "react";

function Pharmacy(props) {
  const {
    name,
    address,
    distance,
  } = props;
  console.log('in pharm')

  return (
    <>
      <div>{name}</div>
      <div>{address}</div>
      <div>{`${distance} miles`}</div>
    </>
  )
}

export default Pharmacy;